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
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF3FF) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imagePath != null)
                  Image.asset(
                    imagePath!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  )
                else if (assetPath != null)
                  AppSvgIcon(
                    useCircleAvatar: true,
                    path: assetPath!,
                    width: 40,
                    height: 40,
                    color: color,
                    fit: BoxFit.scaleDown,
                  )
                else if (iconData != null)
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.greyF5,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconData,
                      size: 20,
                      color: color ?? AppColors.grey33,
                    ),
                  ),
                16.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!showSubtitle) const SizedBox(height: 4),
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
              AppSvgIcon(path: trailingAsset!, fit: BoxFit.scaleDown),
          ],
        ),
      ),
    );
  }
}
