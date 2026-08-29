import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TransactionDetailDialog extends StatelessWidget {
  const TransactionDetailDialog({super.key, required this.transaction});

  final AirtimeToCashTransaction transaction;

  static Future<void> show(BuildContext context, AirtimeToCashTransaction txn) {
    return context.showPopUp(TransactionDetailDialog(transaction: txn));
  }

  Color get _statusColor {
    switch (transaction.status) {
      case AirtimeToCashTxnStatus.success:
        return AppColors.success;
      case AirtimeToCashTxnStatus.failed:
        return AppColors.error;
      case AirtimeToCashTxnStatus.partial:
        return AppColors.warning;
      case AirtimeToCashTxnStatus.pending:
        return AppColors.grey80;
    }
  }

  Widget _row(BuildContext context, String label, String value,
      {Color? valueColor, bool strike = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: context.textTheme.bodySmall
                  ?.copyWith(color: AppColors.grey80)),
          Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              color: valueColor,
              decoration: strike ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel =
        DateFormat('MMM d, yyyy, h:mm:ss a').format(transaction.dateTime);
    final isFailed = transaction.status == AirtimeToCashTxnStatus.failed;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Transaction Details', style: context.textTheme.titleMedium),
          const Divider(height: 24),
          _row(context, 'Product/Service', 'Airtime To Cash'),
          _row(context, 'Amount',
              '₦${transaction.amountSold.toStringAsFixed(2)}',
              valueColor: AppColors.success),
          _row(context, 'Transaction Type', transaction.type.label),
          _row(context, 'Date & Time', dateLabel),
          _row(context, 'Reference:', transaction.reference),
          _row(context, 'Status', transaction.status.label,
              valueColor: _statusColor),
          const Divider(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Airtime To Cash Details',
                style: context.textTheme.bodyMedium),
          ),
          _row(context, 'Phone number Number', transaction.phoneNumber),
          _row(context, 'Network', transaction.networkName),
          _row(context, 'Conversion Rate',
              '${transaction.conversionRatePercent}%'),
          _row(
            context,
            'Amount Received',
            '₦${transaction.amountReceived.toStringAsFixed(2)}',
            strike: isFailed,
          ),
          SizedBox(height: 16.h),
          BundlegramButton(
            text: 'Close',
            width: double.infinity,
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
    );
  }
}
