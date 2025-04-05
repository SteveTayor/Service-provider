
import 'package:bundlegram/core/router/router.dart';
import 'package:bundlegram/core/utils/themes.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, c) {
          return DevicePreview(
              builder: (context) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child:  MaterialApp(
                      themeMode: ThemeMode.light,
                      theme: AppTheme.darkTheme,
                      darkTheme: AppTheme.darkTheme,
 
                      home: const SplashScreen(),
                       
                      routes: AppRouter.routes,
                      debugShowCheckedModeBanner: false,
                    ),
                );
              },);
        },);
  }
}
