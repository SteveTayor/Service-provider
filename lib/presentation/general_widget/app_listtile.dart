import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    this.assetPath,
    required this.title,
    this.subtitle,
    this.trailingAsset,
    this.onPressed,
    this.titleColor,
    this.imagePath,
    this.iconData,
    this.showSubtitle = false,
    this.isSelected = false,
    this.color,
    super.key,
  });

  final String? assetPath;
  final String? trailingAsset;
  final Color? titleColor;
  final VoidCallback? onPressed;
  final String title;
  final String? subtitle;
  final bool showSubtitle;
  final String? imagePath;
  final IconData? iconData;
  final Color? color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Leading icon
            if (imagePath != null)
              Image.asset(
                imagePath!,
                width: 40.w,
                height: 40.w,
                fit: BoxFit.fill,
              )
            else if (assetPath != null)
              AppSvgIcon(
                useCircleAvatar: true,
                path: assetPath!,
                width: 40.w,
                height: 40.w,
                color: color,
                fit: BoxFit.scaleDown,
              )
            else if (iconData != null)
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  // color: AppColors.greyF5,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  size: 20.sp,
                  color: color ?? AppColors.grey33,
                ),
              ),

            16.horizontalSpace,

            // Text content
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: titleColor ?? AppColors.black,
                    ),
                  ),

                  if (showSubtitle && subtitle != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall!.copyWith(
                          color: titleColor ?? AppColors.subtitleColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Trailing icon
            if (trailingAsset != null) ...[
              8.horizontalSpace,
              AppSvgIcon(path: trailingAsset!, fit: BoxFit.scaleDown),
            ],
          ],
        ),
      ),
    );
  }
}
