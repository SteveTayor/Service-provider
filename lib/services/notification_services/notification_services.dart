import 'dart:convert';
import 'dart:io';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
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

  Future<void> initialize() async {
    // firebase init,
    // try {
    //   await Firebase.initializeApp();
    // } catch (e) {
    //   if (kDebugMode)
    //     debugPrint(
    //         'Firebase initialize error (possibly already initialized): $e');
    // }
    final androidPlugin =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(_pushChannel);
    await androidPlugin?.createNotificationChannel(_generalChannel);
    await androidPlugin?.createNotificationChannel(_scheduledChannel);

    // Init local notifications
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (kDebugMode) debugPrint('Notification tapped: ${response.payload}');
        // _handleNotificationTap(response.payload);
        if (response.payload != null) {
          final data = jsonDecode(response.payload!) as Map<dynamic, dynamic>;
          _handleNotificationTap(Map<String, dynamic>.from(data));
        }
      },
    );

    // timezone
    tz.initializeTimeZones();

    // permissions
    await _requestPermissions();

    // set up messaging listeners & token
    await _initializeFirebaseMessaging();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      // Android 13+ uses runtime notification permission; plugin helper:
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      await _firebaseMessaging.requestPermission(
          alert: true, badge: true, sound: true);
    } else if (Platform.isIOS || Platform.isMacOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      if (kDebugMode)
        debugPrint('FCM permission status: ${settings.authorizationStatus}');
      // small delay so system can catch up
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> _initializeFirebaseMessaging() async {
    try {
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // APNs token (iOS) - use retry because it may not be ready immediately
      String? apnsToken = await _getAPNSTokenWithRetry();
      if (kDebugMode) debugPrint('APNs token: $apnsToken');

      // FCM token
      String? token = await _firebaseMessaging.getToken();
      if (kDebugMode) debugPrint('FCM token: $token');

      if (token != null) {
        await _saveTokenToServer(token);
      }

      // token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) async {
        if (kDebugMode) debugPrint('FCM token refreshed: $newToken');
        // await SecureStorageHelper.saveFcmToken(token);
        await _saveTokenToServer(newToken);
      });

      // foreground messages -> show local notification
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode)
          debugPrint('FCM onMessage: ${message.notification?.title}');
        if (message.notification != null) {
          displayPushNotification(message);
          final context = navigatorKey.currentContext;
          if (context != null) {
            // showInAppBanner(message, context);
            InAppBanner.show(
              context,
              title: message.notification!.title ?? 'New Notification',
              body: message.notification!.body ?? '',
              // onTap: () {
              //   _handleNotificationTap(message.data);
              // },
            );
          }
        }
      });

      // Background -> opened app
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (kDebugMode)
          debugPrint('onMessageOpenedApp: ${message.notification?.title}');
        // _handleNotificationTap(
        //     message.data['payload']?.toString() ?? message.data.toString());
        _handleNotificationTap(message.data);
      });

      // Terminated -> opened via notification
      _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
        if (message != null) {
          if (kDebugMode)
            debugPrint('getInitialMessage: ${message.notification?.title}');
          // _handleNotificationTap(
          //     message.data['payload']?.toString() ?? message.data.toString());
          _handleNotificationTap(message.data);
        }
      });
    } catch (e) {
      if (kDebugMode) debugPrint('Error initializing Firebase Messaging: $e');
    }
  }

  // void showInAppBanner(RemoteMessage message, BuildContext context) {
  //   final title = message.notification?.title ?? 'New notification';
  //   final body = message.notification?.body ?? '';

  //   showOverlayNotification(
  //     (context) {
  //       return Material(
  //         color: Colors.transparent,
  //         child: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(12.r),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(0.15),
  //                 blurRadius: 12,
  //                 offset: const Offset(0, 4),
  //               ),
  //             ],
  //           ),
  //           child: InkWell(
  //             onTap: () {
  //               OverlaySupportEntry.of(context)?.dismiss();
  //               // Navigate to notifications screen
  //               context.push(RouteConstants.notification);
  //             },
  //             borderRadius: BorderRadius.circular(12.r),
  //             child: Padding(
  //               padding: EdgeInsets.all(14.w),
  //               child: Row(
  //                 children: [
  //                   // App icon
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(8.r),
  //                     child: Image.asset(
  //                       'assets/images/ic_launcher-playstore.png',
  //                       width: 30.w,
  //                       height: 30.h,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   SizedBox(width: 12.w),

  //                   // Title and body
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Text(
  //                           title,
  //                           style: TextStyle(
  //                             fontSize: 12.sp,
  //                             fontWeight: FontWeight.w600,
  //                             color: Colors.black87,
  //                           ),
  //                           maxLines: 1,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         if (body.isNotEmpty) ...[
  //                           SizedBox(height: 4.h),
  //                           Text(
  //                             body,
  //                             style: TextStyle(
  //                               fontSize: 10.sp,
  //                               color: Colors.black54,
  //                               height: 1.3,
  //                             ),
  //                             maxLines: 2,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                         ],
  //                       ],
  //                     ),
  //                   ),

  //                   SizedBox(width: 8.w),

  //                   // Subtle indicator
  //                   Icon(
  //                     Icons.chevron_right,
  //                     color: Colors.black26,
  //                     size: 12.sp,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //     duration: const Duration(seconds: 4),
  //     position: NotificationPosition.top,
  //   );
  // }

  Future<String?> _getAPNSTokenWithRetry() async {
    String? apnsToken;
    int retryCount = 0;
    const maxRetries = 10;
    const retryDelay = Duration(milliseconds: 500);

    while (apnsToken == null && retryCount < maxRetries) {
      try {
        apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken == null) {
          if (kDebugMode)
            debugPrint(
                'APNs token not available yet, retrying... ${retryCount + 1}/$maxRetries');
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
      const platformDetails =
          NotificationDetails(android: androidDetails, iOS: iosDetails);

      await _notificationsPlugin.show(
        message.hashCode,
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
        platformDetails,
        payload:
            // message.data['payload']?.toString() ??
            jsonEncode(message.data),
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
    const platformDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(id, title, body, platformDetails,
        payload: payload);
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
    const platformDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformDetails,
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

  //to navigate to specific route on tap
  // void _handleNotificationTap(String? payload) {
  //   if (kDebugMode) debugPrint('Handling tap with payload: $payload');
  //   try {
  //     if (navigatorKey.currentState != null) {
  //       //  message screen
  //       navigatorKey.currentState!.pushNamed('/messages', arguments: payload);
  //     }
  //   } catch (e) {
  //     if (kDebugMode) debugPrint('Navigation error on notification tap: $e');
  //   }
  // }
  void _handleNotificationTap(Map<String, dynamic> data) {
    if (kDebugMode) debugPrint('Notification data: $data');

    final type = data['type']?.toString();
    final route = data['route']?.toString();

    if (navigatorKey.currentState == null) return;

    switch (type) {
      case 'message':
        navigatorKey.currentState!.pushNamed(
          RouteConstants.notification,
          arguments: data['conversationId'],
        );
        break;

      case 'security':
        navigatorKey.currentState!.pushNamed(
          RouteConstants.setting,
        );
        break;
      case 'withdraw':
      case 'transaction':
        navigatorKey.currentState!.pushNamed(
          RouteConstants.notification,
        );

        break;

      default:
        // fallback
        if (route != null) {
          navigatorKey.currentState!.pushNamed(route as String);
        }
    }
  }
}

class InAppBanner {
  static void show(
    BuildContext context, {
    required String title,
    required String body,
    // String? imagePath,
    VoidCallback? onTap,
    Duration duration = const Duration(seconds: 4),
  }) {
    showOverlayNotification(
      (overlayContext) {
        return Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.only(top: 20.w),
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
                    // App icon or custom image
                    // if (imagePath != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        "assets/images/ic_launcher-playstore.png",
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

                    // Title and body
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

                    // Subtle indicator
                    //   Icon(
                    //     Icons.chevron_right,
                    //     color: Colors.black26,
                    //     size: 12.sp,
                    //   ),
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
