import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ResultStatusKind { success, partial, processing, failure }

/// Generic status popup used for async/pending outcome and failure
class ResultStatusDialog extends StatelessWidget {
  const ResultStatusDialog({
    super.key,
    required this.kind,
    required this.title,
    required this.message,
    this.detailLines = const [],
    this.onPrimaryPressed,
    this.primaryLabel = 'Done',
    this.secondaryLabel,
    this.onSecondaryPressed,
  });

  final ResultStatusKind kind;
  final String title;
  final String message;
  final List<String> detailLines;
  final VoidCallback? onPrimaryPressed;
  final String primaryLabel;

  /// When set, renders a secondary text action beneath the primary
  /// button — used for the failure state's "Close" alongside "Try Again".
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;

  static Future<void> show(
    BuildContext context, {
    required ResultStatusKind kind,
    required String title,
    required String message,
    List<String> detailLines = const [],
    VoidCallback? onPrimaryPressed,
    String primaryLabel = 'Done',
    String? secondaryLabel,
    VoidCallback? onSecondaryPressed,
  }) {
    return context.showPopUp(
      ResultStatusDialog(
        kind: kind,
        title: title,
        message: message,
        detailLines: detailLines,
        onPrimaryPressed: onPrimaryPressed,
        primaryLabel: primaryLabel,
        secondaryLabel: secondaryLabel,
        onSecondaryPressed: onSecondaryPressed,
      ),
    );
  }

  IconData get _icon {
    switch (kind) {
      case ResultStatusKind.success:
        return Icons.check_circle_outline;
      case ResultStatusKind.partial:
        return Icons.error_outline;
      case ResultStatusKind.processing:
        return Icons.hourglass_top_outlined;
      case ResultStatusKind.failure:
        return Icons.error_outline;
    }
  }

  Color get _color {
    switch (kind) {
      case ResultStatusKind.success:
        return AppColors.success;
      case ResultStatusKind.partial:
        return AppColors.warning;
      case ResultStatusKind.processing:
        return AppColors.info;
      case ResultStatusKind.failure:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _color, width: 1.5),
            ),
            child: Icon(_icon, color: _color, size: 32.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          if (detailLines.isEmpty)
            Text(
              message,
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            )
          else ...[
            for (final line in detailLines)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  line,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 20.h),
          BundlegramButton(
            text: primaryLabel,
            width: double.infinity,
            onPressed:
                onPrimaryPressed ??
                () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          if (secondaryLabel != null) ...[
            SizedBox(height: 8.h),
            TextButton(
              onPressed:
                  onSecondaryPressed ??
                  () => Navigator.of(context, rootNavigator: true).pop(),
              child: Text(
                secondaryLabel!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey8E,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
