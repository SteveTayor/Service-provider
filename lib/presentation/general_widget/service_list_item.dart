import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ServiceListItem extends ConsumerWidget {
  const ServiceListItem({
    super.key,
    required this.transaction,
  });

  final UserTransactions transaction;

  @override
  Widget build(BuildContext context, WidgetRef _ref) {
    final title = transaction.transType == "fund_wallet"
        ? "Top-up"
        : transaction.transType == "withdrawal"
            ? transaction.transType
            : transaction.subProduct?.subName?.capitalizeFullname ?? 'Unknown';
    final type = transaction.transType == "fund_wallet"
        ? "Top-up"
        : transaction.transType == "withdrawal"
            ? transaction.transType
            : transaction.subProduct?.product?.productName?.toLowerCase() ??
                'unknown';
    final status = transaction.status?.capitalizeFirst ?? 'Unknown';
    final date = _formatDate(transaction.createdAt);
    final amount = (transaction.transType == "fund_wallet" ||
            transaction.transType == "withdrawal")
        ? transaction.amount.toCurrency()
        : transaction.deductAmount.toCurrency();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: _getServiceColor(type!).withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: _getServiceIcon(type),
        ),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              SizedBox(height: 2),
              Text(
                title!,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      status,
                      style: context.textTheme.labelMedium!.copyWith(
                        fontSize: 12,
                        color: _getStatusColor(status),
                      ),
                    ),
                  ),
                  Text(
                    ' - $date',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.dateColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      print('Invalid date: null'); // Debug
      return '--';
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final txnDate = DateTime(date.year, date.month, date.day);
    if (txnDate == today) return 'Today';
    if (txnDate == yesterday) return 'Yesterday';
    return DateFormat('MMM d, yyyy').format(date); // e.g. Jul 26, 2025
  }

  Widget _getServiceIcon(String type) {
    final key = type.toLowerCase().trim();

    if (key.contains('top') || key.contains('wallet') || key.contains('fund')) {
      return AppSvgIcon(path: Assets.svgs.topup);
    }
    if (key.contains('airtime')) {
      return AppSvgIcon(path: Assets.svgs.airtime);
    }
    if (key.contains('data') || key.contains('internet')) {
      return AppSvgIcon(path: Assets.svgs.mobileData);
    }
    if (key.contains('cable') ||
        key.contains('dstv') ||
        key.contains('gotv') ||
        key.contains('startimes')) {
      return AppSvgIcon(path: Assets.svgs.cableTv);
    }
    if (key.contains('bet')) {
      return AppSvgIcon(path: Assets.svgs.betting);
    }
    if (key.contains('education') ||
        key.contains('exam') ||
        key.contains('school')) {
      return AppSvgIcon(path: Assets.svgs.educationSvg);
    }
    if (key.contains('electricity') || key.contains('power')) {
      return AppSvgIcon(path: Assets.svgs.electricity);
    }
    if (key.contains('voucher') || key.contains('e-pin')) {
      return AppSvgIcon(path: Assets.svgs.ePin);
    }
    if (key.contains('withdraw') || key.contains('transfer')) {
      return AppSvgIcon(path: Assets.svgs.topup);
    }

    return AppSvgIcon(path: Assets.svgs.wallet);
  }

  Color _getServiceColor(String type) {
    final key = type.toLowerCase();

    final serviceColorMap = <String, Color>{
      'top-up': const Color(0xFFE53E3E),
      'airtime': const Color(0xFFE53E3E),
      'cable tv': const Color(0xFF2D3748),
      'betting': const Color(0xFF553C9A),
      'education': const Color(0xFF9F7AEA),
      'mobile data': const Color(0xFF3182CE),
      'internet': const Color(0xFF3182CE),
      'electricity': const Color(0xFFD69E2E),
      'e-pin voucher': const Color(0xFF38A169),
    };

    // Partial match check
    for (final entry in serviceColorMap.entries) {
      if (key.contains(entry.key)) {
        return entry.value;
      }
    }

    return AppColors.primaryColor;
  }

  Color _getStatusColor(String status) {
    final key = status.toLowerCase();
    switch (key) {
      case 'successful':
      case 'success':
        return AppColors.success;
      case 'failed':
        return AppColors.error;
      case 'pending':
        return AppColors.pending;
      default:
        return AppColors.grey8E;
    }
  }
}
