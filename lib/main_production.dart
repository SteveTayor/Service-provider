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
  // This callback runs in its own background isolate — Firebase and the
  // notification channels created in the foreground isolate are NOT
  // automatically available here, so both must be (re)initialized before
  // displayPushNotification can actually post anything.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initialize();

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
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    _setupGlobalErrorHandling();

    // Block first frame on things the app cannot safely run without.
    await _initializeFirebase();
    await NotificationService().initialize();
    await _loadEnv();
    await _configureSystemUI();

    // Genuinely non-critical / explicitly designed not to block boot.
    unawaited(_checkAppVersion());

    await bootstrap(
      () => ProviderScope(
        child: DevicePreview(
          enabled: false,
          builder: (_) => const OverlaySupport.global(child: App()),
        ),
      ),
    );
  }, _handleGlobalError);
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
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (e, st) {
    // Most commonly a "duplicate app" error on hot restart, or a
    // misconfigured platform Firebase file. Either way this must not take
    // the whole app down before runZonedGuarded even gets a chance.
    debugPrint('Firebase initialize error: $e\n$st');
  }
}

Future<void> _checkAppVersion() async {
  try {
    const storage = FlutterSecureStorage();
    final secureStorage = SecureStorageHelper(storage);
    final versionManager = VersionManager(secureStorage);
    await versionManager.checkAndHandleAppUpdate();
  } catch (e, st) {
    debugPrint('Version check failed: $e\n$st');
    // Non-fatal — never blocks app boot.
  }
}

void _setupGlobalErrorHandling() {
  FlutterError.onError = (details) {
    // Always show Flutter's own formatted console dump / red error screen
    // first — this used to be skipped entirely in debug mode, which meant
    // losing the built-in error UI during development.
    FlutterError.presentError(details);
    if (!kDebugMode) {
      _handleGlobalError(
        details.exception,
        details.stack ?? StackTrace.current,
      );
    }
  };

  // Renders in place of the default grey error box outside of debug mode,
  // e.g. if a widget's build() throws after the app is already running.
  ErrorWidget.builder = (details) {
    if (kDebugMode) return ErrorWidget(details.exception);
    return MiniErrorScreen(details: details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) return false;
    _handleGlobalError(error, stack);
    return true;
  };
}

/// ------------------------------------------------------------
/// Global error handler
/// ------------------------------------------------------------
void _handleGlobalError(Object error, StackTrace? stack) {
  debugPrint('Global error: $error');
  if (stack != null) debugPrintStack(stackTrace: stack);

  // TODO: send to a crash-reporting backend (e.g. Firebase Crashlytics)
  // once that dependency is added to pubspec.yaml — currently this is
  // console-only and nothing is captured in release builds.

  final navContext = navigatorKey.currentContext;
  if (navContext != null) {
    debugPrint('UI available to display error');
    // Optional: show snackbar / dialog
  }
}

/// ------------------------------------------------------------
/// Minimal error screen shown via ErrorWidget.builder outside debug mode
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
