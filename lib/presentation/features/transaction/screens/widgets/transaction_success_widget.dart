import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TransactionSuccessful extends StatelessWidget {
  const TransactionSuccessful({
    required this.title,
    required this.subTitle,
    this.isCloseAccount = false,
    this.isBasicInfo = false,
    super.key,
  });
  final String title;
  final String subTitle;
  final bool isCloseAccount;
  final bool isBasicInfo;

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
      body: ResultWidget(
        appIcon: AppSvgIcon(
          path: Assets.svgs.successfulIllustration,
        ),
        title: title,
        subText: subTitle,
        buttonText: isCloseAccount == true
            ? 'Okay!'
            : isBasicInfo == true
                ? 'Continue'
                : 'Go to home',
        onPressed: () {
          context.pushReplacement(RouteConstants.dashboard);
        },
      ),
    );
  }
}
