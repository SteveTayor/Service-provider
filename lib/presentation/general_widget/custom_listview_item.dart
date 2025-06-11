import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListItem<T> extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.item,
    required this.itemBuilder,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.margin,
    this.padding,
    this.showDivider = false,
    this.dividerColor,
    this.elevation = 0,
  });

  final T item;
  final Widget Function(T item) itemBuilder;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;
  final Color? dividerColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        child: Container(
          padding: padding ?? EdgeInsets.all(16.w),
          child: Column(
            children: [
              itemBuilder(item),
              if (showDivider) ...[
                SizedBox(height: 8.h),
                Divider(
                  color: dividerColor ?? AppColors.greyD0.withOpacity(0.3),
                  height: 1,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
