import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/async_value/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable widget to handle AsyncValue states with clean error handling
class AppAsyncBuilder<T> extends ConsumerWidget {
  final AsyncValue<T> state;
  final Widget Function(BuildContext context, WidgetRef ref, T data) builder;
  final String? errorMessage;
  final Widget? loadingWidget;
  final bool showRetryButton;
  final VoidCallback? onRetry;

  const AppAsyncBuilder({
    super.key,
    required this.state,
    required this.builder,
    this.errorMessage,
    this.loadingWidget,
    this.showRetryButton = true,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return state.when(
      data: (data) => builder(context, ref, data),
      loading: () =>
          loadingWidget ??
          Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
      error: (error, stack) => Center(
        child: Container(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 28.sp,
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
                      backgroundColor: AppColors.background),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
