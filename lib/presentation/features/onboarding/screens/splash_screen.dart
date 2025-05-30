import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/router/app_router.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _goToWalkThrough() {
    context.go(RouteConstants.walkThrough);
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
