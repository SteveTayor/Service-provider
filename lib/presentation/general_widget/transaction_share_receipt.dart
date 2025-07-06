import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/customizable.row.dart';
import 'package:bundlegram/presentation/general_widget/dash_paint.dart';
import 'package:bundlegram/presentation/general_widget/repaint_canvas.dart';
import 'package:flutter/material.dart';
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
        // Main receipt container
        Container(
          width: MediaQuery.of(context).size.width,
          height: 573.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Column(
            children: [
              _buildHeader(context),
              40.verticalSpace,
              Expanded(child: _buildDetailsScrollView(context)),
              _buildBottomAction(),
            ],
          ),
        ),
        _buildReceiptCutEdge(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 16.w, 0),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Transaction details',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose ?? () => Navigator.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: AppSvgIcon(path: Assets.svgs.close),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsScrollView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          ..._buildTransactionDetails(context),
          16.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Column(
      children: [
        _buildDashedDivider(),
        8.verticalSpace,
        if (showShareButton)
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 40.h),
            child: BundlegramButton(
              text: 'Share receipt',
              width: double.infinity,
              height: 48.h,
              onPressed: onShareReceipt ?? () {},
              buttonStyle: BundlegramButtonStyle.primary(),
            ),
          )
        else
          40.verticalSpace,
      ],
    );
  }

  Widget _buildDashedDivider() {
    return SizedBox(
      width: double.infinity,
      height: 1.h,
      child: CustomPaint(painter: DashedLinePainter()),
    );
  }

  Widget _buildReceiptCutEdge() {
    return SizedBox(
      height: 10.h,
      width: double.infinity,
      child: CustomPaint(
        painter: ReceiptCutPainter(),
        size: Size(double.infinity, 10.h),
      ),
    );
  }

  List<Widget> _buildTransactionDetails(BuildContext context) {
    final List<Widget> details = [
      _TransactionDetailItem(
        label: 'Transaction ID',
        value: data.transactionId!,
        showCopyIcon: true,
      ),
      _TransactionDetailItem(label: 'Date', value: data.date!),
      _TransactionDetailItem(label: 'Time', value: data.time!),
      _TransactionDetailItem(label: 'Type', value: data.type!),
      _TransactionDetailItem(
        label: 'Amount',
        value: data.amount.toCurrency(),
      ),
      if (data.bankName != null)
        _TransactionDetailItem(label: 'Bank name', value: data.bankName!),
      if (data.accountNumber != null)
        _TransactionDetailItem(
            label: 'Account number', value: data.accountNumber!),
      _TransactionDetailItem(
        label: 'Transaction status',
        value: data.status,
        valueColor: _getStatusColor(),
      ),
      if (data.reference != null)
        _TransactionDetailItem(label: 'Reference', value: data.reference!),
    ];

    return details
        .map((item) => Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: item,
            ))
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 14.sp,
              color: AppColors.grey33,
            ),
          ),
        ),
        16.horizontalSpace,

        // Value + Copy
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
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: valueColor ?? AppColors.black,
                      ),
                  textAlign: TextAlign.right,
                ),
              ),
              if (showCopyIcon) ...[
                8.horizontalSpace,
                GestureDetector(
                  onTap: () => Clipboard.setData(ClipboardData(text: value)),
                  child: AppSvgIcon(path: Assets.svgs.copy),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
