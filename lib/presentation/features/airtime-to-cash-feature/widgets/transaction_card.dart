import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/phone_mask.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// Mobile card representation of a single transaction row, matching:
///   ₦5,000 Airtime
///   ₦4,500 received
///   MTN • 080••••1234
///   Today, 10:42 AM
///   Success
class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  final AirtimeToCashTransaction transaction;
  final VoidCallback onTap;

  Color _statusColor() {
    switch (transaction.status) {
      case AirtimeToCashTxnStatus.success:
        return AppColors.success;
      case AirtimeToCashTxnStatus.failed:
        return AppColors.error;
      case AirtimeToCashTxnStatus.processing:
        return AppColors.warning;
      case AirtimeToCashTxnStatus.partial:
        return AppColors.warning;
      case AirtimeToCashTxnStatus.pending:
        return AppColors.grey80;
    }
  }

  String _statusDisplayLabel() {
    switch (transaction.status) {
      case AirtimeToCashTxnStatus.success:
        return 'Success';
      case AirtimeToCashTxnStatus.failed:
        return 'Failed';
      case AirtimeToCashTxnStatus.processing:
        return 'Processing';
      case AirtimeToCashTxnStatus.partial:
        return 'Partial';
      case AirtimeToCashTxnStatus.pending:
        return 'Pending';
    }
  }

  String _dateLabel() {
    final now = DateTime.now();
    final isToday =
        now.year == transaction.dateTime.year &&
        now.month == transaction.dateTime.month &&
        now.day == transaction.dateTime.day;
    final timePart = DateFormat('h:mm a').format(transaction.dateTime);
    if (isToday) return 'Today, $timePart';
    return '${DateFormat('MMM d').format(transaction.dateTime)}, $timePart';
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.greyEE),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₦${transaction.amountSold.toStringAsFixed(0)} Airtime',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '₦${transaction.amountReceived.toStringAsFixed(0)} received',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    _statusDisplayLabel(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Text(
                  transaction.networkName,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey33,
                  ),
                ),
                Text(
                  ' • ',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.grey80,
                  ),
                ),
                Text(
                  maskPhoneNumber(transaction.phoneNumber),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.grey80,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              _dateLabel(),
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.grey80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
