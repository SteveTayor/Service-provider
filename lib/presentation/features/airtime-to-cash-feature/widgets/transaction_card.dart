import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/phone_mask.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// Maps a transaction's network id/code to its logo asset — same codes used
/// for network selection (MTN, AIRTEL, GLO, 9MOBILE). Returns null for any
/// unrecognized id so the UI can fall back to a generic icon instead of
/// throwing on a missing asset.
String? _logoAssetFor(String networkId) {
  switch (networkId.toUpperCase()) {
    case 'MTN':
      return Assets.svgs.mtnnw;
    case 'AIRTEL':
      return Assets.svgs.airtel;
    case 'GLO':
      return Assets.svgs.glo;
    case '9MOBILE':
      return Assets.svgs.a9mobile;
    default:
      return null;
  }
}

/// Mobile card representation of a single transaction row, service-list
/// style, matching:
///   [LOGO]  ₦5,000 Airtime                    Success
///           MTN • 080••••1234
///           Today, 10:42 AM
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
    final logoAsset = _logoAssetFor(transaction.networkId);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.greyEE),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Provider logo tile — same rounded-square treatment as the
            // network selector, so a transaction row reads as one item in
            // a service list rather than a plain text block.
            Container(
              width: 44.w,
              height: 44.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.greyF5,
                shape: BoxShape.circle,
              ),
              child: logoAsset != null
                  ? ClipOval(
                      child: AppSvgIcon(
                        path: logoAsset,
                        width: 26.w,
                        height: 26.w,
                      ),
                    )
                  : Icon(
                      Icons.sim_card_outlined,
                      size: 22.sp,
                      color: AppColors.grey80,
                    ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transaction.networkName.toUpperCase()} Airtime',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Row(
                    children: [
                      Text(
                        _statusDisplayLabel(),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: statusColor,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          _dateLabel(),
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            color: AppColors.grey80,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Text(
              '₦${transaction.amountSold.toStringAsFixed(0)}',
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
