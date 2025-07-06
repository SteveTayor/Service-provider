import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ServiceListItem extends StatelessWidget {
  const ServiceListItem({
    super.key,
    required this.transaction,
  });

  final UserTransactions transaction;

  @override
  Widget build(BuildContext context) {
    final title = transaction.subProduct?.subName ?? 'Unknown';
    final type = transaction.subProduct?.product?.productName ?? 'unknown';
    final status = transaction.status?.capitalizeFullname ?? '';
    final date = _formatDate(transaction.createdAt.toString());
    final amount = transaction.amount?.toCurrency() ?? '₦0.00';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon (network or fallback SVG)
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: _getServiceColor(type).withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child:
              // iconUrl != null && iconUrl.isNotEmpty
              //     ? ClipRRect(
              //         borderRadius: BorderRadius.circular(80.w),
              //         child: Image.network(
              //           iconUrl,
              //           width: 40.w,
              //           height: 40.w,
              //           fit: BoxFit.cover,
              //           errorBuilder: (_, __, ___) => _getServiceIcon(type),
              //         ),
              //       )
              // :
              _getServiceIcon(type),
        ),
        12.horizontalSpace,

        // Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.capitalizeFullname,
                style: context.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
              ),
              4.verticalSpace,
              Row(
                children: [
                  Flexible(
                    child: Text(
                      status,
                      style: context.textTheme.bodySmall!.copyWith(
                        fontSize: 12.sp,
                        color: _getStatusColor(status),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '  -  $date',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.dateColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Amount
        Text(
          amount,
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatDate(String? dateStr) {
    final dt = dateStr?.toDateTime();
    if (dt == null) return '--';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final txnDate = DateTime(dt.year, dt.month, dt.day);

    if (txnDate == today) return 'Today';
    if (txnDate == yesterday) return 'Yesterday';

    return DateFormat('MM d, yy').format(dt); // ➤ e.g., July 6, 2025
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
    if (key.contains('cable')) {
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
