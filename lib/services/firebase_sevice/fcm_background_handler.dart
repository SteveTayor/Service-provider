import 'package:bundlegram/services/notification_services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> fcmBackgroundHandler(RemoteMessage message) async {
  // initialize Firebase if you plan to use other Firebase services here
  await Firebase.initializeApp();
  if (kDebugMode) {
    debugPrint('*** FCM bg message: ${message.messageId}');
    debugPrint('data: ${message.data}');
    debugPrint(
        'notification: ${message.notification?.title} / ${message.notification?.body}');
  }

  // You can display a local notification from background if safe on the platform:
  try {
    await NotificationService().displayPushNotification(message);
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Error while showing local notification in bg: $e');
    }
  }
}
