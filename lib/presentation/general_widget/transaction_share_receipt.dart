import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/customizable.row.dart';
import 'package:bundlegram/presentation/general_widget/dash_paint.dart';
import 'package:bundlegram/presentation/general_widget/repaint_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionReceiptWidget extends StatelessWidget {
  TransactionReceiptWidget({
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
  final GlobalKey _shareKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Main container for the transaction receipt popup
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
              30.verticalSpace,
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
    // Header with title and close button
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 16.w, 0),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Transaction details',
                style: context.textTheme.titleMedium?.copyWith(
                  // fontSize: 18,
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
    // Scrollable area for transaction details
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
    // Bottom section with share and close buttons
    return Column(
      children: [
        _buildDashedDivider(),
        8.verticalSpace,
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 40.h),
          child: Column(
            children: [
              if (showShareButton)
                BundlegramButton(
                  text: 'Share receipt',
                  width: double.infinity,
                  height: 35.h,
                  onPressed: onShareReceipt ?? () {},
                  buttonStyle: BundlegramButtonStyle.primary(),
                ),
              if (onClose != null) 16.verticalSpace,
              if (onClose != null)
                BundlegramButton(
                  text: 'Close',
                  width: double.infinity,
                  height: 35.h,
                  onPressed: onClose,
                  buttonStyle: BundlegramButtonStyle.primary(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDivider() {
    // Dashed line separator
    return SizedBox(
      width: double.infinity,
      height: 1.h,
      child: CustomPaint(painter: DashedLinePainter()),
    );
  }

  Widget _buildReceiptCutEdge() {
    // Cut edge design at the top of the receipt
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
    // Build list of transaction detail items based on available data
    final List<Widget> details = [
      _TransactionDetailItem(
        label: 'Transaction ID',
        value: data.transactionId!,
        showCopyIcon: true,
      ),
      _TransactionDetailItem(label: 'Date', value: data.date!),
      _TransactionDetailItem(label: 'Time', value: data.time!),
      _TransactionDetailItem(
          label: 'Transaction type', value: getTransactionType()),
      if (data.paymentMethod != null)
        _TransactionDetailItem(
          label: 'Payment channel',
          value: data.paymentMethod!,
        ),
      _TransactionDetailItem(label: 'Amount', value: data.amount!),
      if (data.phoneNumber != null)
        _TransactionDetailItem(label: 'Beneficiary', value: data.phoneNumber!),
      if (data.type?.toLowerCase() == 'electricity' && data.token != null)
        _TransactionDetailItem(
          label: 'Token',
          value: data.token!,
          showCopyIcon: true, // Enable copy for token
        ),
      if (data.smartCardNumber != null)
        _TransactionDetailItem(
            label: 'Smartcard Number', value: data.smartCardNumber!),
      if (data.network != null)
        _TransactionDetailItem(label: 'Network', value: data.network!),
      if (data.meterNumber != null)
        _TransactionDetailItem(label: 'Meter Number', value: data.meterNumber!),
      if (data.accountNumber != null)
        _TransactionDetailItem(label: 'Account', value: data.accountNumber!),
      if (data.balanceBefore != null)
        _TransactionDetailItem(
          label: 'Balance Before',
          value: data.balanceBefore!,
        ),
      if (data.userBalance != null)
        _TransactionDetailItem(
          label: 'Balance After',
          value: data.userBalance!,
        ),
      _TransactionDetailItem(
        label: 'Transaction status',
        value: data.status,
        valueColor: _getStatusColor(),
      ),
      if (data.type?.toLowerCase() == 'electricity' && data.units != null)
        _TransactionDetailItem(label: 'Units', value: data.units!),
      if (data.reference != null)
        _TransactionDetailItem(label: 'Reference', value: data.reference!),
    ];

    return details
        .map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: item,
          ),
        )
        .toList();
  }

  String getTransactionType() {
    switch (data.type?.toLowerCase()) {
      case 'mobile_data':
        return 'Mobile Data';
      case 'electricity':
        return 'Electricity';
      case 'airtime':
        return 'Airtime';
      case 'cable_tv':
        return 'Cable TV';
      case 'internet_service':
        return 'Internet Service';
      case 'fund_wallet':
        return 'Top-up';
      case 'withdrawal':
        return 'Withdrawal';
      case 'betting':
        return 'Betting';
      default:
        return data.type!.capiTalizeFirstLast;
    }
  }

  Color _getStatusColor() {
    // Determine color based on transaction status
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
    // Row layout for label and value with optional copy icon
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            // fontSize: 12,
            color: AppColors.grey33,
          ),
        ),
        16.horizontalSpace,
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: valueStyle ??
                      context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        // fontSize: 12,
                        color: valueColor ?? AppColors.black,
                      ),
                  textAlign: TextAlign.right,
                ),
              ),
              if (showCopyIcon) ...[
                8.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value));
                    navigatorKey.currentState!.context
                        .showCustomSnackBar("Copied to clipboard");
                  },
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
