import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/async_value/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable error widget for displaying errors with optional retry functionality
// class AppErrorWidget extends StatelessWidget {
//   final Object error;
//   final String? errorMessage;
//   final bool showRetryButton;
//   final VoidCallback? onRetry;
//   final double? iconSize;
//   final EdgeInsetsGeometry? padding;

//   const AppErrorWidget({
//     super.key,
//     required this.error,
//     this.errorMessage,
//     this.showRetryButton = true,
//     this.onRetry,
//     this.iconSize,
//     this.padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: padding ?? EdgeInsets.all(8.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: iconSize ?? 28.sp,
//               color: AppColors.error.withOpacity(0.7),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               errorMessage ?? ErrorMessageSanitizer.sanitize(error),
//               style: context.textTheme.labelSmall?.copyWith(
//                 color: AppColors.black.withOpacity(0.8),
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//             if (showRetryButton) ...[
//               SizedBox(height: 16.h),
//               TextButton.icon(
//                 onPressed: onRetry ?? () {},
//                 icon: Icon(
//                   Icons.refresh,
//                   size: 18.sp,
//                   color: AppColors.primaryColor,
//                 ),
//                 label: Text(
//                   'Try Again',
//                   style: context.textTheme.bodyMedium?.copyWith(
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 style: TextButton.styleFrom(
//                   foregroundColor: AppColors.primaryColor,
//                   backgroundColor: AppColors.background,
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
class AppErrorWidget extends StatelessWidget {
  final Object error;
  final String? errorMessage;
  final bool showRetryButton;
  final VoidCallback? onRetry;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;

  const AppErrorWidget({
    super.key,
    required this.error,
    this.errorMessage,
    this.showRetryButton = true,
    this.onRetry,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          size: iconSize ?? 28.sp,
          color: AppColors.error.withOpacity(0.7),
        ),
        SizedBox(height: 8.h),
        Text(
          errorMessage ?? ErrorMessageSanitizer.sanitize(error),
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.black.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        if (showRetryButton) ...[
          SizedBox(height: 16.h),
          TextButton.icon(
            onPressed: onRetry ?? () {},
            icon: Icon(
              Icons.refresh,
              size: 18.sp,
              color: AppColors.primaryColor,
            ),
            label: Text(
              'Try Again',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              backgroundColor: AppColors.background,
            ),
          ),
        ],
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Unbounded height (e.g. inside a scroll view) -> just size to
        // content, no Center needed.
        if (!constraints.maxHeight.isFinite) {
          return Padding(
            padding: padding ?? EdgeInsets.all(8.w),
            child: content,
          );
        }

        // Bounded (possibly very tight, even 0) height -> let it scroll
        // internally rather than overflow. A SingleChildScrollView clips
        // to its given size instead of painting outside it, so this is
        // what actually kills the yellow/black stripes.
        return Center(
          child: Padding(
            padding: padding ?? EdgeInsets.all(8.w),
            child: SingleChildScrollView(child: content),
          ),
        );
      },
    );
  }
}
