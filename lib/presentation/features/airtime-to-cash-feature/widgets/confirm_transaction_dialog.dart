import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/phone_mask.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// "Review Conversion" confirmation, shown before final submission.
class ConfirmTransactionDialog extends StatelessWidget {
  const ConfirmTransactionDialog({
    super.key,
    required this.network,
    required this.phoneNumber,
    required this.amountToSell,
    required this.amountToReceive,
  });

  final NetworkConfig network;
  final String phoneNumber;
  final double amountToSell;
  final double amountToReceive;

  static Future<Future<dynamic>> show(
    BuildContext context, {
    required NetworkConfig network,
    required String phoneNumber,
    required double amountToSell,
    required double amountToReceive,
  }) async {
    return context.showPopUp(
      ConfirmTransactionDialog(
        network: network,
        phoneNumber: phoneNumber,
        amountToSell: amountToSell,
        amountToReceive: amountToReceive,
      ),
    );
  }

  Widget _row(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey80,
            ),
          ),
          Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Review Conversion', style: context.textTheme.titleMedium),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.greyF5,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AppSvgIcon(
                  path: network.logoAsset,
                  width: 20.w,
                  height: 20.w,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    network.name,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    maskPhoneNumber(phoneNumber),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey80,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 28.h, color: AppColors.greyEE),
          _row(
            context,
            'Airtime to sell',
            '₦${amountToSell.toStringAsFixed(0)}',
          ),
          _row(context, 'Conversion rate', '${network.conversionRatePercent}%'),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("You'll receive", style: context.textTheme.bodyMedium),
                Text(
                  '₦${amountToReceive.toStringAsFixed(0)}',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          BundlegramButton(
            text: 'Confirm Conversion',
            width: double.infinity,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(true),
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(false),
            child: Text(
              'Go Back',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.grey8E,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
