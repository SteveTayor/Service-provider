import 'dart:convert';
import 'dart:io';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // channels
  static const AndroidNotificationChannel _pushChannel =
      AndroidNotificationChannel(
        'push_channel',
        'Push Notifications',
        description: 'Channel for FCM push notifications',
        importance: Importance.max,
        playSound: true,
      );
  static const AndroidNotificationChannel _generalChannel =
      AndroidNotificationChannel(
        'general_channel',
        'General Notifications',
        description: 'Channel for general app notifications',
        importance: Importance.max,
      );

  static const AndroidNotificationChannel _scheduledChannel =
      AndroidNotificationChannel(
        'scheduled_channel',
        'Scheduled Notifications',
        description: 'Channel for scheduled notifications',
        importance: Importance.max,
      );

  bool _initialized = false;

  /// Creates notification channels, initializes the local-notifications
  /// plugin, requests permissions, and wires up FCM listeners.
  ///
  /// Must be called (and awaited) once — from `main()`, after Firebase is
  /// initialized — before any notification can actually display. This also
  /// needs to run inside `firebaseMessagingBackgroundHandler`'s isolate,
  /// since Android notification channels created in the foreground isolate
  /// are not visible to the separate background isolate.
  Future<void> initialize() async {
    if (_initialized) return;

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.createNotificationChannel(_pushChannel);
    await androidPlugin?.createNotificationChannel(_generalChannel);
    await androidPlugin?.createNotificationChannel(_scheduledChannel);

    // Init local notifications
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (kDebugMode) debugPrint('Notification tapped: ${response.payload}');
        if (response.payload == null) return;
        try {
          final data = jsonDecode(response.payload!) as Map<String, dynamic>;
          _handleNotificationTap(data);
        } catch (e) {
          if (kDebugMode)
            debugPrint('Failed to decode notification payload: $e');
        }
      },
    );

    // timezone
    tz.initializeTimeZones();

    // permissions
    await _requestPermissions();

    // set up messaging listeners & token
    await _initializeFirebaseMessaging();

    _initialized = true;
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      // Android 13+ uses runtime notification permission; plugin helper:
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      NotificationSettings settings = await _firebaseMessaging
          .requestPermission(
            alert: true,
            badge: true,
            sound: true,
            provisional: false,
          );
      if (kDebugMode) {
        debugPrint('FCM permission status: ${settings.authorizationStatus}');
      }
      // small delay so system can catch up
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> _initializeFirebaseMessaging() async {
    try {
      // We display all incoming foreground notifications ourselves via
      // displayPushNotification (onMessage below), so tell iOS not to also
      // auto-present its own system banner — otherwise notification-payload
      // messages would show twice while the app is foregrounded.
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: false,
        badge: false,
        sound: false,
      );

      // APNs token (iOS only) - use retry because it may not be ready
      // immediately. Skipped entirely on Android, where it's meaningless
      // and would otherwise add up to 5s of pure delay before listeners
      // below are registered.
      if (Platform.isIOS) {
        final apnsToken = await _getAPNSTokenWithRetry();
        if (kDebugMode) debugPrint('APNs token: $apnsToken');
      }

      // FCM token
      String? token = await _firebaseMessaging.getToken();
      if (kDebugMode) debugPrint('FCM token: $token');

      if (token != null) {
        await _saveTokenToServer(token);
      }

      // token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) async {
        if (kDebugMode) debugPrint('FCM token refreshed: $newToken');
        await _saveTokenToServer(newToken);
      });

      // foreground messages -> show local notification
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          debugPrint('FCM onMessage: ${message.notification?.title}');
        }
        if (message.notification != null) {
          displayPushNotification(message);
          final context = navigatorKey.currentContext;
          if (context != null) {
            InAppBanner.show(
              context,
              title: message.notification!.title ?? 'New Notification',
              body: message.notification!.body ?? '',
              onTap: () => _handleNotificationTap(message.data),
            );
          }
        }
      });

      // Background -> opened app
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (kDebugMode) {
          debugPrint('onMessageOpenedApp: ${message.notification?.title}');
        }
        _handleNotificationTap(message.data);
      });

      // Terminated -> opened via notification
      _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
        if (message != null) {
          if (kDebugMode) {
            debugPrint('getInitialMessage: ${message.notification?.title}');
          }
          _handleNotificationTap(message.data);
        }
      });
    } catch (e) {
      if (kDebugMode) debugPrint('Error initializing Firebase Messaging: $e');
    }
  }

  Future<String?> _getAPNSTokenWithRetry() async {
    String? apnsToken;
    int retryCount = 0;
    const maxRetries = 10;
    const retryDelay = Duration(milliseconds: 500);

    while (apnsToken == null && retryCount < maxRetries) {
      try {
        apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken == null) {
          if (kDebugMode) {
            debugPrint(
              'APNs token not available yet, retrying... ${retryCount + 1}/$maxRetries',
            );
          }
          await Future.delayed(retryDelay);
          retryCount++;
        }
      } catch (e) {
        if (kDebugMode) debugPrint('Error getting APNs token: $e');
        await Future.delayed(retryDelay);
        retryCount++;
      }
    }
    return apnsToken;
  }

  /// Deterministic, 32-bit-safe notification ID derived from the message.
  /// `RemoteMessage.hashCode` is not guaranteed to fit Android's int32
  /// notification-ID range and risks collisions; this does.
  int _notificationIdFor(RemoteMessage message) {
    final seed = message.messageId ?? message.sentTime?.toIso8601String() ?? '';
    if (seed.isEmpty) {
      return DateTime.now().millisecondsSinceEpoch.remainder(1 << 31);
    }
    return seed.hashCode & 0x7FFFFFFF;
  }

  Future<void> displayPushNotification(RemoteMessage message) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'push_channel',
        'Push Notifications',
        channelDescription: "Channel for FCM push notifications",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );
      const iosDetails = DarwinNotificationDetails();
      const platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notificationsPlugin.show(
        id: _notificationIdFor(message),
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
        notificationDetails: platformDetails,
        payload: jsonEncode(message.data),
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Error displaying push notification: $e');
    }
  }

  // Public helper to show app-initiated notifications
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'general_channel',
      'General Notifications',
      channelDescription: 'Channel for general app notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: platformDetails,
      payload: payload,
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'Channel for scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: platformDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload,
    );
  }

  //to register token with server
  Future<void> _saveTokenToServer(String token) async {
    try {
      // TODO: Replace with DioClient/locator post to your backend:
      // await DioClient.getInstance.post('/device/register', data: {'token': token, 'platform': Platform.operatingSystem});
      if (kDebugMode) debugPrint('Would send token to server: $token');
    } catch (e) {
      if (kDebugMode) debugPrint('Error saving token to server: $e');
    }
  }

  /// Navigates on notification tap. Uses go_router via the root context,
  /// not `Navigator.pushNamed` — this app has no named-route table for
  /// `pushNamed` to resolve against (routing is entirely GoRouter-based),
  /// so `pushNamed` would fail or no-op here.
  void _handleNotificationTap(Map<String, dynamic> data) {
    if (kDebugMode) debugPrint('Notification data: $data');

    final type = data['type']?.toString();
    final route = data['route']?.toString();
    final context = navigatorKey.currentContext;
    if (context == null) return;

    switch (type) {
      case 'message':
        context.push(
          RouteConstants.notification,
          extra: data['conversationId'],
        );
        break;

      case 'security':
        context.push(RouteConstants.setting);
        break;

      case 'withdraw':
      case 'transaction':
        context.push(RouteConstants.notification);
        break;

      default:
        if (route != null) {
          context.push(route);
        }
    }
  }
}

class InAppBanner {
  static void show(
    BuildContext context, {
    required String title,
    required String body,
    VoidCallback? onTap,
    Duration duration = const Duration(seconds: 4),
  }) {
    showOverlayNotification(
      (overlayContext) {
        return Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.only(top: 20.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                OverlaySupportEntry.of(overlayContext)?.dismiss();
                onTap?.call();
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        Assets.images.icLauncherPlaystore.path,
                        width: 30.w,
                        height: 30.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.image,
                              size: 16.sp,
                              color: Colors.grey.shade600,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (body.isNotEmpty) ...[
                            SizedBox(height: 4.h),
                            Text(
                              body,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black54,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      duration: duration,
      position: NotificationPosition.top,
    );
  }
}
