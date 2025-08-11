import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
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
    Future.delayed(const Duration(seconds: 5), _goToWalkThrough);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSvgIcon(
                  width: 150,
                  height: 150,
                  path: Assets.svgs.bundlegramWhiteLogo,
                  color: AppColors.background,
                ),
              ],
            ),
          ),
          Text(
            "Powered by CodeFixBug",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
