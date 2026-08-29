import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// Mobile card representation of a single transaction row. Deliberately
/// not a literal port of the desktop table shown in the reference
/// screenshots — the fields are the same, but laid out for a narrow screen.
class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {super.key, required this.transaction, required this.onTap});

  final AirtimeToCashTransaction transaction;
  final VoidCallback onTap;

  Color _statusColor() {
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

  @override
  Widget build(BuildContext context) {
    final dateLabel =
        DateFormat('MMM d, yyyy, h:mm a').format(transaction.dateTime);
    final statusColor = _statusColor();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.greyEE),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₦${transaction.amountSold.toStringAsFixed(0)}',
                  style: context.textTheme.titleSmall,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    transaction.status.label,
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: statusColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(dateLabel,
                style: context.textTheme.bodySmall
                    ?.copyWith(color: AppColors.grey80)),
            SizedBox(height: 6.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.greyF5,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(transaction.networkName,
                      style: context.textTheme.labelSmall),
                ),
                SizedBox(width: 8.w),
                Text(transaction.phoneNumber,
                    style: context.textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
