import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  static Future<dynamic> show(
    BuildContext context, {
    required NetworkConfig network,
    required String phoneNumber,
    required double amountToSell,
    required double amountToReceive,
  }) {
    return context.showPopUp(
      ConfirmTransactionDialog(
        network: network,
        phoneNumber: phoneNumber,
        amountToSell: amountToSell,
        amountToReceive: amountToReceive,
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value,
      {Color? valueColor}) {
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
        children: [
          Icon(Icons.info_outline, color: AppColors.warning, size: 40.sp),
          SizedBox(height: 12.h),
          Text('Confirm Transaction', style: context.textTheme.titleMedium),
          SizedBox(height: 12.h),
          _row(context, 'Network:', network.name),
          _row(context, 'Phone Number:', phoneNumber),
          _row(
              context, 'Amount to Sell:', '₦${amountToSell.toStringAsFixed(0)}',
              valueColor: AppColors.warning),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('You will receive', style: context.textTheme.bodySmall),
                Text(
                  '₦${amountToReceive.toStringAsFixed(0)}',
                  style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.success, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          _row(context, 'Type:', 'INSTANT'),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: BundlegramButton(
                  text: 'Cancel',
                  color: AppColors.greyEE,
                  textStyle: TextStyle(color: AppColors.black),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(false),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: BundlegramButton(
                  text: 'Confirm & Submit',
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
