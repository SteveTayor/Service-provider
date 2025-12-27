import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BulkPinSuccessResultScreen extends StatelessWidget {
  String? subtitle =
      'Your bulk e-pin purchase was successful. You can now access your e-pins in the e-pin section of your account.';
  BulkPinSuccessResultScreen({
    super.key,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
      body: ResultWidget(
        appIcon: AppSvgIcon(
          path: Assets.svgs.successfulIllustration,
        ),
        title: 'Details submitted!',
        subText: subtitle!,
        buttonText: 'Go to home',
        onPressed: () {
          context.push(RouteConstants.dashboard);
        },
      ),
    );
  }
}
