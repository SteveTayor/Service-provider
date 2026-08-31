// import 'package:bundlegram/core/extensions/responsive_extensions.dart';
// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/utils/colors.dart';
// import 'package:bundlegram/presentation/general_widget/app_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PlatformItemWidget extends StatelessWidget {
//   const PlatformItemWidget({
//     required this.title,
//     required this.onPressed,
//     this.icon,
//     this.iconData,
//     super.key,
//   }) : assert(
//          icon != null || iconData != null,
//          'Provide either icon (asset path) or iconData (fallback Material icon)',
//        );

//   final String title;
//   final String? icon;
//   final IconData? iconData;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     final r = context.responsive;
//     final circleSize = r.spacing(52);

//     return GestureDetector(
//       onTap: onPressed,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             width: circleSize,
//             height: circleSize,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: const Color(0xffDDB9B4).withOpacity(0.48),
//             ),
//             child: icon != null
//                 ? AppSvgIcon(path: icon!)
//                 : Icon(
//                     iconData,
//                     color: AppColors.white,
//                     size: r.iconSize(base: 22),
//                   ),
//           ),
//           SizedBox(height: r.spacing(8)),
//           SizedBox(
//             // Give the label a bounded, predictable width instead of
//             // letting it size to its natural (unbounded) text width.
//             width: circleSize + r.spacing(35),
//             child: Text(
//               title,
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: context.textTheme.bodyMedium!.copyWith(
//                 color: AppColors.white,
//                 fontSize: r.textSize(14),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
  final String? icon;
  final IconData? iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Fall back to a sane default if the parent gives unbounded width
        // (shouldn't happen once this sits inside an Expanded, but keeps
        // this widget safe to use standalone too).
        final maxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : r.spacing(90);

        // Circle scales with the slot it's given: bigger slot (fewer
        // items) -> bigger circle; smaller slot (more items) -> smaller
        // circle, clamped to a usable range so it never gets silly.
        final circleSize = (maxWidth * 0.62).clamp(
          r.spacing(44),
          r.spacing(64),
        );
        final iconInset = circleSize * 0.42;

        return GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffDDB9B4).withOpacity(0.48),
                ),
                child: icon != null
                    ? AppSvgIcon(
                        path: icon!,
                        width: iconInset,
                        height: iconInset,
                      )
                    : Icon(
                        iconData,
                        color: AppColors.white,
                        size: iconInset,
                      ),
              ),
              SizedBox(height: r.spacing(8)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r.spacing(4)),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.white,
                    fontSize: r.textSize(14),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}