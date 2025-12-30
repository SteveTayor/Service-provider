import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/responsive_extensions.dart';
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
    this.useResponsive = true,
  });

  final TransactionReceiptData data;
  final VoidCallback? onShareReceipt;
  final VoidCallback? onClose;
  final bool showShareButton;
  final bool useResponsive;
  final GlobalKey _shareKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    // Adaptive height based on device
    final dialogHeight = useResponsive
        ? r.when(
            phone: MediaQuery.of(context).size.height * 0.63, // 63% on phone
            tablet: MediaQuery.of(context).size.height * 0.65, // 65% on tablet
            desktop: 650.0, // Fixed on desktop
          )
        : 573.h;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: dialogHeight,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                useResponsive ? r.radiusSize(16) : 16.r,
              ),
            ),
          ),
          child: Column(
            children: [
              _buildHeader(context),
              SizedBox(height: useResponsive ? r.spacing(4) : 4.h),
              const Divider(color: AppColors.divider),
              SizedBox(height: useResponsive ? r.spacing(26) : 26.h),
              Expanded(child: _buildDetailsScrollView(context)),
              _buildBottomAction(context),
            ],
          ),
        ),
        _buildReceiptCutEdge(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        useResponsive ? r.spacing(24) : 24.w,
        useResponsive ? r.spacing(24) : 24.h,
        useResponsive ? r.spacing(16) : 16.w,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Transaction details',
                style: useResponsive
                    ? TextStyle(
                        fontSize: r.textSize(22),
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      )
                    : context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose ?? () => Navigator.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.all(
                useResponsive ? r.spacing(4) : 4.w,
              ),
              child: AppSvgIcon(path: Assets.svgs.close),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsScrollView(BuildContext context) {
    final r = context.responsive;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: useResponsive ? r.spacing(24) : 24.w,
      ),
      child: Column(
        children: [
          ..._buildTransactionDetails(context),
          SizedBox(height: useResponsive ? r.spacing(16) : 16.h),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    final r = context.responsive;

    return Column(
      children: [
        _buildDashedDivider(context),
        SizedBox(height: useResponsive ? r.spacing(8) : 8.h),
        Padding(
          padding: EdgeInsets.fromLTRB(
            useResponsive ? r.spacing(24) : 24.w,
            useResponsive ? r.spacing(32) : 32.h,
            useResponsive ? r.spacing(24) : 24.w,
            useResponsive ? r.spacing(40) : 40.h,
          ),
          child: Column(
            children: [
              if (showShareButton)
                BundlegramButton(
                  text: 'Share receipt',
                  width: double.infinity,
                  height: useResponsive ? r.spacing(35) : 35.h,
                  useResponsive: useResponsive,
                  onPressed: onShareReceipt ?? () {},
                  buttonStyle: BundlegramButtonStyle.primary(),
                ),
              if (onClose != null)
                SizedBox(height: useResponsive ? r.spacing(16) : 16.h),
              if (onClose != null)
                BundlegramButton(
                  text: 'Close',
                  width: double.infinity,
                  height: useResponsive ? r.spacing(35) : 35.h,
                  useResponsive: useResponsive,
                  onPressed: onClose,
                  buttonStyle: BundlegramButtonStyle.primary(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDivider(BuildContext context) {
    final r = context.responsive;

    return SizedBox(
      width: double.infinity,
      height: useResponsive ? r.spacing(1) : 1.h,
      child: CustomPaint(painter: DashedLinePainter()),
    );
  }

  Widget _buildReceiptCutEdge(BuildContext context) {
    final r = context.responsive;

    final edgeHeight = useResponsive ? r.spacing(10) : 10.h;

    return SizedBox(
      height: edgeHeight,
      width: double.infinity,
      child: CustomPaint(
        painter: ReceiptCutPainter(),
        size: Size(double.infinity, edgeHeight),
      ),
    );
  }

  List<Widget> _buildTransactionDetails(BuildContext context) {
    final r = context.responsive;

    final List<Widget> details = [
      _TransactionDetailItem(
        label: 'Transaction ID',
        value: data.transactionId!,
        showCopyIcon: true,
        useResponsive: useResponsive,
      ),
      _TransactionDetailItem(
        label: 'Date',
        value: data.date!,
        useResponsive: useResponsive,
      ),
      _TransactionDetailItem(
        label: 'Time',
        value: data.time!,
        useResponsive: useResponsive,
      ),
      _TransactionDetailItem(
        label: 'Transaction type',
        value: getTransactionType(),
        useResponsive: useResponsive,
      ),
      if (data.paymentMethod != null)
        _TransactionDetailItem(
          label: 'Payment channel',
          value: data.paymentMethod!,
          useResponsive: useResponsive,
        ),
      _TransactionDetailItem(
        label: 'Amount',
        value: data.amount!,
        useResponsive: useResponsive,
      ),
      if (data.phoneNumber != null)
        _TransactionDetailItem(
          label: 'Beneficiary',
          value: data.phoneNumber!,
          useResponsive: useResponsive,
        ),
      if (data.type?.toLowerCase() == 'electricity' && data.token != null)
        _TransactionDetailItem(
          label: 'Token',
          value: data.token!.formatAsToken(),
          showCopyIcon: true,
          useResponsive: useResponsive,
        ),
      if (data.smartCardNumber != null)
        _TransactionDetailItem(
          label: 'Smartcard Number',
          value: data.smartCardNumber!,
          useResponsive: useResponsive,
        ),
      if (data.network != null)
        _TransactionDetailItem(
          label: 'Network',
          value: data.network!,
          useResponsive: useResponsive,
        ),
      if (data.dataBundle != null)
        _TransactionDetailItem(
          label: 'Data Bundle',
          value: data.dataBundle!,
          useResponsive: useResponsive,
        ),
      if (data.meterNumber != null)
        _TransactionDetailItem(
          label: 'Meter Number',
          value: data.meterNumber!,
          useResponsive: useResponsive,
        ),
      if (data.quantity != null && data.quantity!.isNotEmpty)
        _TransactionDetailItem(
          label: 'Quantity',
          value: data.quantity!,
          useResponsive: useResponsive,
        ),
      if (data.accountNumber != null)
        _TransactionDetailItem(
          label: data.type?.toLowerCase() == 'betting'
              ? 'Betting ID'
              : (data.type?.toLowerCase() == 'top-up' ||
                      data.type?.toLowerCase() == 'fund_wallet' ||
                      data.type?.toLowerCase() == 'withdrawal')
                  ? "Beneficiary"
                  : "Account",
          value: data.accountNumber!,
          useResponsive: useResponsive,
        ),
      if (data.balanceBefore != null)
        _TransactionDetailItem(
          label: 'Balance Before',
          value: data.balanceBefore!,
          useResponsive: useResponsive,
        ),
      if (data.userBalance != null)
        _TransactionDetailItem(
          label: 'Balance After',
          value: data.userBalance!,
          useResponsive: useResponsive,
        ),
      _TransactionDetailItem(
        label: 'Transaction status',
        value: data.status,
        valueColor: _getStatusColor(),
        useResponsive: useResponsive,
      ),
      if (data.type?.toLowerCase() == 'electricity' && data.units != null)
        _TransactionDetailItem(
          label: 'Units',
          value: data.units!,
          useResponsive: useResponsive,
        ),
      if (data.reference != null)
        _TransactionDetailItem(
          label: 'Reference',
          value: data.reference!,
          useResponsive: useResponsive,
        ),
    ];

    return details
        .map(
          (item) => Padding(
            padding: EdgeInsets.only(
              bottom: useResponsive ? r.spacing(16) : 16.h,
            ),
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
    this.useResponsive = true,
  });

  final String label;
  final String value;
  final bool showCopyIcon;
  final Color? valueColor;
  final TextStyle? valueStyle;
  final bool useResponsive;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: useResponsive
              ? TextStyle(
                  fontSize: r.textSize(12),
                  color: AppColors.grey2F,
                  fontWeight: FontWeight.w600,
                )
              : context.textTheme.labelMedium?.copyWith(
                  color: AppColors.grey2F,
                  fontWeight: FontWeight.w600,
                ),
        ),
        SizedBox(width: useResponsive ? r.spacing(16) : 16.w),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value.replaceAll("_", " "),
                  style: valueStyle ??
                      (useResponsive
                          ? TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: r.textSize(12),
                              color: valueColor ?? AppColors.black,
                            )
                          : context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: valueColor ?? AppColors.black,
                            )),
                  textAlign: TextAlign.right,
                ),
              ),
              if (showCopyIcon) ...[
                SizedBox(width: useResponsive ? r.spacing(8) : 8.w),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
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
