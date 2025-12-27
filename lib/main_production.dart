import 'dart:async';

import 'package:bundlegram/bootstrap.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/datasources/local/version_manager.dart';
import 'package:bundlegram/firebase_options.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/general_widget/async_value/error_widget.dart';
import 'package:bundlegram/services/notification_services/notification_services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");

//   // Initialize Firebase
//   await Firebase.initializeApp(
//     name: 'bundlegram',
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // Register FCM background handler
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   // Initialize NotificationService (local + FCM listeners)
//   await NotificationService().initialize();

//   // Launch app
//   await bootstrap(
//     () => ProviderScope(
//       child: DevicePreview(
//         enabled: false, // set to false in production
//         builder: (context) => const App(),
//       ),
//     ),
//   );
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // Init Firebase first (only once).
  await Firebase.initializeApp(
    name: 'bundlegram',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register background handler (must be a top-level or static function).
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay styles
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Then initialize Firebase & notifications in the background
  unawaited(_initializeFirebaseAndMessaging());
  // Check for app updates and handle stale data BEFORE app starts
  await _checkAppVersionAndClearStaleData();
  // Prefer runZonedGuarded to capture uncaught async errors too.
  await runZonedGuarded(
    () async {
      // Framework errors
      FlutterError.onError = (FlutterErrorDetails details) {
        // keep default logging
        FlutterError.presentError(details);
        _handleGlobalError(details.exception, details.stack);
      };

      // Uncaught errors on the platform dispatcher (async)
      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        _handleGlobalError(error, stack);
        return true; // prevent default red screen
      };

      // start the app
      await bootstrap(
        () => ProviderScope(
          child: DevicePreview(
            enabled: false,
            builder: (context) => const App(),
          ),
        ),
      );
    },
    _handleGlobalError,
  );
}

/// Check app version and clear stale data if app was updated
Future<void> _checkAppVersionAndClearStaleData() async {
  try {
    const storage = FlutterSecureStorage();
    final secureStorage = SecureStorageHelper(storage);
    final versionManager = VersionManager(secureStorage);

    final wasUpdated = await versionManager.checkAndHandleAppUpdate();

    if (wasUpdated) {
      debugPrint(
          '✅ App was updated - stale data cleared, critical data preserved');
    } else {
      debugPrint('✅ App version check complete - no update detected');
    }
  } catch (e, st) {
    debugPrint('⚠️ Error checking app version: $e\n$st');
    // Don't block app launch if version check fails
  }
}

Future<void> _initializeFirebaseAndMessaging() async {
  try {
    await Firebase.initializeApp(
      name: 'bundlegram',
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await NotificationService().initialize();

    debugPrint("Firebase + Messaging initialized");
  } catch (e, st) {
    debugPrint("Error initializing Firebase/Notifications: $e\n$st");
  }
}

/// Global error handling helper
void _handleGlobalError(Object error, StackTrace? stack) {
  final sanitizedMessage = ErrorMessageSanitizer.sanitize(error);

  // Always log for diagnostics
  debugPrint('Global error caught: $sanitizedMessage');
  if (stack != null) debugPrintStack(stackTrace: stack);

  // If the app UI (navigator) is mounted.
  final navState = navigatorKey.currentState;
  final navContext = navigatorKey.currentContext;

  if (navState?.mounted == true && navContext != null) {
    // so it works even when no Scaffold is directly available
    // ScaffoldMessenger.of(navContext).showSnackBar(
    //   SnackBar(
    //     content: Text(sanitizedMessage, style: TextStyle(color: Colors.white)),
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: AppColors.primaryColor,
    //   ),
    // );
    debugPrint('UI available. Error: $sanitizedMessage');
  } else {
    // UI not ready — swallow gracefully, log or persist if needed
    debugPrint(
        'UI not available to show error snack. Error: $sanitizedMessage');
  }
}
