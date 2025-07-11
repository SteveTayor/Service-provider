import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FailedResultScreen extends StatelessWidget {
  final String serviceContent;
  final String title;
  final String errorMessage;
  final VoidCallback? onRetry;

  const FailedResultScreen({
    super.key,
    this.errorMessage = 'Please, check your connection and try again..',
    this.title = 'Purchase failed!',
    this.onRetry,
    required this.serviceContent,
  });

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
      body: ResultWidget(
        appIcon: AppSvgIcon(
          path: Assets.svgs.failedIllustration,
        ),
        title: title,
        subText: 'Your ${serviceContent} failed. $errorMessage',
        buttonText: 'Retry',
        onPressed: onRetry ?? () => context.pop(),
      ),
    );
  }
}
