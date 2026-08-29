import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirtimeSharePinInfoDialog extends StatelessWidget {
  const AirtimeSharePinInfoDialog({super.key, required this.networks});

  final List<NetworkConfig> networks;

  static Future<void> show(BuildContext context, List<NetworkConfig> networks) {
    return context.showPopUp(AirtimeSharePinInfoDialog(networks: networks));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline, color: AppColors.info, size: 40.sp),
          SizedBox(height: 12.h),
          Text(
            'What is Airtime Share PIN?',
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            'Airtime Share PIN is a 4-digit security code required to transfer '
            'airtime from your phone.',
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerLeft,
            child:
                Text('How to set it up:', style: context.textTheme.bodyMedium),
          ),
          SizedBox(height: 8.h),
          ...networks.map(
            (n) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${n.name}: Dial ${n.shareCode}',
                  style: context.textTheme.bodySmall,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'If you forgot your PIN, dial 300 to reset it.',
            style: context.textTheme.bodySmall,
          ),
          SizedBox(height: 20.h),
          BundlegramButton(
            text: 'OK',
            width: double.infinity,
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
    );
  }
}
