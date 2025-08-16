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
    this.showSubtitle = false,
    this.isSelected = false, // New parameter for selection state
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
  final Color? color;
  final bool isSelected; // Tracks if this tile is selected

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF3FF) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
              CrossAxisAlignment.center, // Changed from .end to .center
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Added this for inner row alignment
              children: [
                if (imagePath != null)
                  Image.asset(
                    imagePath!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                if (assetPath != null)
                  AppSvgIcon(
                    path: assetPath!,
                    width: 40,
                    height: 40,
                    color: color ?? null,
                    fit: BoxFit.scaleDown,
                  ),
                16.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment:
                  //     MainAxisAlignment.center, // Changed from .end to .center
                  children: [
                    if (!showSubtitle)
                      SizedBox(
                        height: 4,
                      ),
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
                            // fontSize: 14,
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
      ),
    );
  }
}
