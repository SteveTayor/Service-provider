import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/repaint_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionReceiptWidget extends StatelessWidget {
  const TransactionReceiptWidget({
    super.key,
    required this.data,
    this.onShareReceipt,
    this.onClose,
    this.showShareButton = true,
  });

  final TransactionReceiptData data;
  final VoidCallback? onShareReceipt;
  final VoidCallback? onClose;
  final bool showShareButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main receipt container with rounded top corners
        Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main content with padding
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with title and close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction details',
                          style: context.textTheme.headlineMedium,
                        ),
                        GestureDetector(
                          onTap: onClose ?? () => Navigator.of(context).pop(),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Icon(
                              Icons.close,
                              size: 20.w,
                              color: AppColors.grey33,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Transaction details list
                    ..._buildTransactionDetails(context),

                    if (showShareButton) ...[
                      SizedBox(height: 32.h),

                      // Share receipt button
                      BundlegramButton(
                        text: 'Share receipt',
                        width: double.infinity,
                        height: 48.h,
                        onPressed: onShareReceipt ?? () {},
                        buttonStyle: BundlegramButtonStyle.primary(),
                      ),
                    ],

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Receipt cut/tear effect at the bottom
        _buildReceiptCutEdge(),
      ],
    );
  }

  /// Builds the characteristic receipt cut/tear edge at the bottom
  Widget _buildReceiptCutEdge() {
    return Container(
      height: 20.h,
      width: double.infinity,
      child: CustomPaint(
        painter: ReceiptCutPainter(),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTransactionDetails(BuildContext context) {
    final details = [
      _TransactionDetailItem(
        label: 'Transaction ID',
        value: data.transactionId,
        showCopyIcon: true,
      ),
      _TransactionDetailItem(
        label: 'Date',
        value: data.date,
      ),
      _TransactionDetailItem(
        label: 'Time',
        value: data.time,
      ),
      _TransactionDetailItem(
        label: 'Type',
        value: data.type,
      ),
      _TransactionDetailItem(
        label: 'Amount',
        value: data.amount,
        valueStyle: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
      _TransactionDetailItem(
        label: 'Bank name',
        value: data.bankName,
      ),
      _TransactionDetailItem(
        label: 'Account number',
        value: data.accountNumber,
      ),
      _TransactionDetailItem(
        label: 'Transaction status',
        value: data.status,
        valueColor: _getStatusColor(),
      ),
    ];

    // Add optional fields if they exist
    if (data.description != null) {
      details.add(
        _TransactionDetailItem(
          label: 'Description',
          value: data.description!,
        ),
      );
    }

    if (data.reference != null) {
      details.add(
        _TransactionDetailItem(
          label: 'Reference',
          value: data.reference!,
        ),
      );
    }

    return details
        .map(
          (detail) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: detail,
          ),
        )
        .toList();
  }

  Color _getStatusColor() {
    switch (data.status.toLowerCase()) {
      case 'successful':
      case 'completed':
      case 'success':
        return AppColors.success;
      case 'failed':
      case 'declined':
        return AppColors.errorText;
      case 'pending':
      case 'processing':
        return AppColors.pending;
      default:
        return AppColors.grey33;
    }
  }
}

class _TransactionDetailItem extends StatelessWidget {
  const _TransactionDetailItem({
    required this.label,
    required this.value,
    this.showCopyIcon = false,
    this.valueColor,
    this.valueStyle,
  });

  final String label;
  final String value;
  final bool showCopyIcon;
  final Color? valueColor;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey33,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: valueStyle ??
                      context.textTheme.bodyMedium?.copyWith(
                        color: valueColor ?? AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.right,
                ),
              ),
              if (showCopyIcon) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => _copyToClipboard(value),
                  child: Icon(
                    CupertinoIcons.square_stack,
                    size: 16.w,
                    color: AppColors.grey33,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
