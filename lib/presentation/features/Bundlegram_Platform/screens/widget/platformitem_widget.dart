import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformItemWidget extends StatelessWidget {
  const PlatformItemWidget({
    required this.title,
    required this.onPressed,
    this.icon,
    this.iconData,
    super.key,
  }) : assert(
          icon != null || iconData != null,
          'Provide either icon (asset path) or iconData (fallback Material icon)',
        );

  final String title;

  /// Existing behaviour — SVG asset path.
  final String? icon;

  /// New — fallback Material icon for items that don't have a designed
  /// asset yet. Takes precedence only when [icon]
  /// is null, so nothing about the existing four quick actions changes.
  final IconData? iconData;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: r.spacing(52),
            height: r.spacing(52),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffDDB9B4).withOpacity(0.48),
            ),
            child: icon != null
                ? AppSvgIcon(path: icon!)
                : Icon(
                    iconData,
                    color: AppColors.white,
                    size: r.iconSize(base: 22),
                  ),
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            title,
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
