import 'package:bundlegram/bootstrap.dart';
import 'package:bundlegram/firebase_options.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/services/notification_services/notification_services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Register the background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    debugPrint("Handling a background message: ${message.messageId}");
    debugPrint('Message data: ${message.data}');
    debugPrint(
        'Notification: ${message.notification?.title} / ${message.notification?.body}');
  }

  // Optionally show local notification for background message
  try {
    await NotificationService().displayPushNotification(message);
  } catch (e) {
    if (kDebugMode) debugPrint('Error showing bg notification: $e');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Initialize Firebase
  await Firebase.initializeApp(
    name: 'bundlegram',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register FCM background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize NotificationService (local + FCM listeners)
  await NotificationService().initialize();

  // Launch app
  await bootstrap(
    () => ProviderScope(
      child: DevicePreview(
        enabled: false, // set to false in production
        builder: (context) => const App(),
      ),
    ),
  );
}
