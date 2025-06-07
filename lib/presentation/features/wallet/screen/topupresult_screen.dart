import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TopUpResultScreen extends StatelessWidget {
  const TopUpResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
      body: ResultWidget(
        appIcon: AppSvgIcon(
          path: Assets.svgs.successfulIllustration,
        ),
        title: 'Top-up successful!',
        subText:
            'Your wallet top-up was successful. ₦10,000 has been added to your Bundlegram wallet.',
        buttonText: 'Go to home',
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}
