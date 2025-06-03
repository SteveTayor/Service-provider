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
      padding: EdgeInsets.all(padding.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logoWidget,
          SizedBox(width: spacing.w),
          Text(
            brandName!,
            style: TextStyle(
              color: brandColor,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
