import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CableTvSuccessResultScreen extends StatelessWidget {
  final String amount;

  const CableTvSuccessResultScreen({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement(RouteConstants.dashboard);
        return false;
      },
      child: BundlegramScaffold(
        sidePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
        body: ResultWidget(
          appIcon: AppSvgIcon(
            path: Assets.svgs.successfulIllustration,
          ),
          title: 'Payment Successful!',
          subText: 'Your subscription of ${amount} to Cable TV was successful.',
          buttonText: 'Go to home',
          onPressed: () {
            context.pushReplacement(RouteConstants.dashboard);
          },
        ),
      ),
    );
  }
}
