import 'dart:async';

import 'package:bundlegram/core/config/interceptors/inactivity_wrapper.dart';
import 'package:bundlegram/core/providers/app_globals..dart';
import 'package:bundlegram/core/providers/connectivity_provider.dart';
import 'package:bundlegram/core/router/app_router.dart';
import 'package:bundlegram/core/utils/theme/theme_notifier.dart';
import 'package:bundlegram/core/utils/themes.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/datasources/local/version_manager.dart';
import 'package:bundlegram/presentation/no_internet.dart';
import 'package:bundlegram/services/route_memory_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late final RouteMemoryService _routeMemoryService;

  @override
  void initState() {
    super.initState();
    _routeMemoryService = RouteMemoryService(AppRouter.router);
    WidgetsBinding.instance.addObserver(_routeMemoryService);

    _postFrameInit();
  }

  void _postFrameInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeDeferredServices();
    });
  }

  Future<void> _initializeDeferredServices() async {
    unawaited(_checkAppVersion());
  }

  Future<void> _checkAppVersion() async {
    try {
      const storage = FlutterSecureStorage();
      final secureStorage = SecureStorageHelper(storage);
      final versionManager = VersionManager(secureStorage);

      // Runs after the first frame (post-frame callback),
      await versionManager.checkAndHandleAppUpdate();
    } catch (e, st) {
      debugPrint('Version check failed: $e\n$st');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_routeMemoryService);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectivityProv = ref.watch(connectivityStatusProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final themeState = ref.watch(themeProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      builder: (context, _) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            themeMode: ThemeMode.system,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            restorationScopeId: 'app',
            debugShowCheckedModeBanner: false,
            locale: const Locale('en', 'NG'),
            supportedLocales: const [Locale('en', 'NG')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            scaffoldMessengerKey: scaffoldMessengerKey,
            builder: (context, child) {
              // FIX: previously `connectivityProv.when(...)` returned
              // either NoInternetWidget() OR InactivityWrapper(child) —
              // mutually exclusive.
              if (child == null) return const SizedBox();

              return connectivityProv.when(
                data: (status) {
                  final isOffline = status == ConnectivityResult.none;
                  return Stack(
                    children: [
                      InactivityWrapper(child: child),
                      if (isOffline) const NoInternetWidget(),
                    ],
                  );
                },
                loading: () => child,
                error: (_, __) => child,
              );
            },
          ),
        );
      },
    );
  }
}
