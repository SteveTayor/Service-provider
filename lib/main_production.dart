import 'dart:async';

import 'package:bundlegram/bootstrap.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/datasources/local/version_manager.dart';
import 'package:bundlegram/firebase_options.dart';
import 'package:bundlegram/presentation/app.dart';
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
import 'package:overlay_support/overlay_support.dart';

/// ------------------------------------------------------------
/// Firebase background handler
/// ------------------------------------------------------------
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    debugPrint('[FCM BG] ${message.messageId}');
    debugPrint('Data: ${message.data}');
  }

  try {
    await NotificationService().displayPushNotification(message);
  } catch (e) {
    debugPrint('BG notification error: $e');
  }
}

/// ------------------------------------------------------------
/// App entry
/// ------------------------------------------------------------
Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      //  block first frame
      await _initializeFirebase();
      // await _initializeNotifications();

      // defer (DO NOT await)
      unawaited(_loadEnv());
      unawaited(_configureSystemUI());
      // unawaited(_checkAppVersion());

      _setupGlobalErrorHandling();

      await bootstrap(
        () => ProviderScope(
          child: DevicePreview(
            enabled: false,
            builder: (_) => const OverlaySupport.global(
              child: App(),
            ),
          ),
        ),
      );
    },
    _handleGlobalError,
  );
}

/// ------------------------------------------------------------
/// Boot helpers
/// ------------------------------------------------------------

Future<void> _loadEnv() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('⚠️ .env not found, continuing without it');
  }
}

Future<void> _configureSystemUI() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(
    // name: 'bundlegram',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );
}

// Future<void> _initializeNotifications() async {
//   await NotificationService().initialize();
// }

// Future<void> _checkAppVersion() async {
//   unawaited(() async {
//     try {
//       const storage = FlutterSecureStorage();
//       final secureStorage = SecureStorageHelper(storage);
//       final versionManager = VersionManager(secureStorage);

//       await versionManager.checkAndHandleAppUpdate();
//     } catch (e, st) {
//       debugPrint('Version check failed: $e\n$st');
//     }
//   }());
// }

void _setupGlobalErrorHandling() {
  FlutterError.onError = (details) {
    if (kDebugMode) {
      Zone.current.handleUncaughtError(
        details.exception,
        details.stack ?? StackTrace.current,
      );
    } else {
      _handleGlobalError(details.exception, details.stack);
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) return false;
    _handleGlobalError(error, stack);
    return true;
  };
}

// Future<void> _runApp() async {
//   await runZonedGuarded(
//     () async {
//       await bootstrap(
//         () => ProviderScope(
//           child: DevicePreview(
//             enabled: false,
//             builder: (_) => const App(),
//           ),
//         ),
//       );
//     },
//     _handleGlobalError,
//   );
// }

/// ------------------------------------------------------------
/// Global error handler
/// ------------------------------------------------------------
void _handleGlobalError(Object error, StackTrace? stack) {
  debugPrint('Global error: $error');
  if (stack != null) debugPrintStack(stackTrace: stack);

  final navContext = navigatorKey.currentContext;
  if (navContext != null) {
    debugPrint('UI available to display error');
    // Optional: show snackbar / dialog
  }
}

/// ------------------------------------------------------------
/// Optional minimal error screen (debug only)
/// ------------------------------------------------------------
class MiniErrorScreen extends StatelessWidget {
  final FlutterErrorDetails details;

  const MiniErrorScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            details.exceptionAsString(),
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
