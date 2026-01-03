import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/async_value/app_error_wiget.dart';
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
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
      error: (error, stack) => AppErrorWidget(
        error: error,
        errorMessage: errorMessage,
        showRetryButton: showRetryButton,
        onRetry: onRetry,
      ),
    );
  }
}
