import 'package:bundlegram/core/extensions/navigation_extensions.dart';
import 'package:bundlegram/core/router/router.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _goToWalkThrough() {
    context.replaceAll(AppRouter.walkThrough);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _goToWalkThrough);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(child: Image.asset(Assets.images.logo.path)),
    );
  }
}
