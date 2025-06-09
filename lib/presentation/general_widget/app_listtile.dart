import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    this.assetPath,
    this.imagePath,
    required this.title,
    this.subtitle,
    this.trailingAsset,
    this.onPressed,
    this.titleColor,
    this.showSubtitle = false, // Default to false
    super.key,
  });
  final String? assetPath;
  final String? imagePath;
  final String? trailingAsset;
  final Color? titleColor;
  final VoidCallback? onPressed;
  final String title;
  final String? subtitle;
  final bool showSubtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (imagePath != null)
                Image.asset(
                  imagePath!,
                  width: 24.w,
                  height: 24.w,
                  fit: BoxFit.contain,
                )
              else
                AppSvgIcon(
                  path: assetPath!,
                  fit: BoxFit.scaleDown,
                ),
              16.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: titleColor ?? AppColors.black,
                    ),
                  ),
                  if (showSubtitle)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        subtitle!,
                        style: context.textTheme.bodySmall!.copyWith(
                          color: titleColor ?? AppColors.subtitleColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (trailingAsset == null)
            const SizedBox()
          else
            AppSvgIcon(
              path: trailingAsset!,
              fit: BoxFit.scaleDown,
            ),
        ],
      ),
    );
  }
}
