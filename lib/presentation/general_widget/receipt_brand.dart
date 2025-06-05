import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiptBrandingWidget extends StatelessWidget {
  const ReceiptBrandingWidget({
    super.key,
    required this.logoWidget,
    this.brandName,
    this.brandColor = AppColors.primaryColor,
    this.spacing = 8,
    this.padding = 24,
  });

  final Widget logoWidget;
  final String? brandName;
  final Color? brandColor;
  final double spacing;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 30.h,
      // width: 160.w,
      padding: EdgeInsets.all(padding.w),
      child: logoWidget,
    );
  }
}
