import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shown when the /verify response's airtime balance is below the
/// network's stated minimum (e.g. ₦0.57 or ₦10 against a ₦500 minimum) —
/// too low to convert anything at all.
class BalanceTooLowDialog extends StatelessWidget {
  const BalanceTooLowDialog({
    super.key,
    required this.network,
    required this.balance,
  });

  final NetworkConfig network;
  final double? balance;

  static Future<void> show(
    BuildContext context, {
    required NetworkConfig network,
    required double? balance,
  }) {
    return context.showPopUp(
      BalanceTooLowDialog(network: network, balance: balance),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: AppColors.warning,
            size: 40.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            'Airtime Balance Too Low',
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Your ${network.name} airtime balance is '
            '${balance != null ? '₦${balance!.toStringAsFixed(2)}' : 'too low'}, '
            'which is below the ₦${network.minAmount.toStringAsFixed(0)} minimum '
            'needed to convert. Please recharge your airtime and try again.',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey80,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          BundlegramButton(
            text: 'Choose a Different Network',
            width: double.infinity,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    );
  }
}
