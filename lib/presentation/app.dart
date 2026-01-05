import 'package:bundlegram/core/config/interceptors/inactivity_wrapper.dart';
import 'package:bundlegram/core/providers/app_globals..dart';
import 'package:bundlegram/core/providers/connectivity_provider.dart';
import 'package:bundlegram/core/router/app_router.dart';
import 'package:bundlegram/core/utils/themes.dart';
import 'package:bundlegram/presentation/no_internet.dart';
import 'package:bundlegram/services/route_memory_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:bundlegram/presentation/routes/app_router.dart';
// import 'package:bundlegram/presentation/features/onboarding/screens/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// class App extends ConsumerWidget {
//   const App({super.key});
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
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_routeMemoryService);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectivityProv = ref.watch(connectivityStatusProvider);

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
            // restorationScopeId: 'app',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            locale: const Locale('en', 'NG'),
            // builder: DevicePreview.appBuilder,
            // locale: DevicePreview.locale(context),
            supportedLocales: const [Locale('en', 'NG')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // ---------- ----------
            scaffoldMessengerKey: scaffoldMessengerKey,

            // ---
            builder: (context, child) {
              // final connectivityAsync = ref.watch(connectivityProvider);

              return connectivityProv.when(
                data: (status) {
                  final isOffline = status == ConnectivityResult.none;
                  if (isOffline) return const NoInternetWidget();
                  return InactivityWrapper(child: child!);
                },
                loading: () => const SizedBox(), // or Splash/loading screen
                error: (_, __) => const NoInternetWidget(),
              );
            },
          ),
        );
      },
    );
  }
}
