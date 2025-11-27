import 'dart:io';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  Future<void> initialize() async {
    // firebase init,
    try {
      await Firebase.initializeApp();
    } catch (e) {
      if (kDebugMode)
        debugPrint(
            'Firebase initialize error (possibly already initialized): $e');
    }

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
        _handleNotificationTap(response.payload);
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
        }
      });

      // Background -> opened app
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (kDebugMode)
          debugPrint('onMessageOpenedApp: ${message.notification?.title}');
        _handleNotificationTap(
            message.data['payload']?.toString() ?? message.data.toString());
      });

      // Terminated -> opened via notification
      _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
        if (message != null) {
          if (kDebugMode)
            debugPrint('getInitialMessage: ${message.notification?.title}');
          _handleNotificationTap(
              message.data['payload']?.toString() ?? message.data.toString());
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
        payload: message.data['payload']?.toString(),
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
  void _handleNotificationTap(String? payload) {
    if (kDebugMode) debugPrint('Handling tap with payload: $payload');
    try {
      if (navigatorKey.currentState != null) {
        //  message screen
        navigatorKey.currentState!.pushNamed('/messages', arguments: payload);
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Navigation error on notification tap: $e');
    }
  }
}
