import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/phone_mask.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// /// "Review Conversion" confirmation, shown before final submission.
// class ConfirmTransactionDialog extends StatelessWidget {
//   const ConfirmTransactionDialog({
//     super.key,
//     required this.network,
//     required this.phoneNumber,
//     required this.amountToSell,
//     required this.amountToReceive,
//   });

//   final NetworkConfig network;
//   final String phoneNumber;
//   final double amountToSell;
//   final double amountToReceive;

//   static Future<bool?> show(
//     BuildContext context, {
//     required NetworkConfig network,
//     required String phoneNumber,
//     required double amountToSell,
//     required double amountToReceive,
//   }) async {
//     return context.showPopUp<bool>(
//       ConfirmTransactionDialog(
//         network: network,
//         phoneNumber: phoneNumber,
//         amountToSell: amountToSell,
//         amountToReceive: amountToReceive,
//       ),
//     );
//   }

//   Widget _row(
//     BuildContext context,
//     String label,
//     String value, {
//     Color? valueColor,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: context.textTheme.bodySmall?.copyWith(
//               color: AppColors.grey80,
//             ),
//           ),
//           Text(
//             value,
//             style: context.textTheme.bodyMedium?.copyWith(
//               color: valueColor,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Review Conversion', style: context.textTheme.titleMedium),
//           SizedBox(height: 16.h),
//           Row(
//             children: [
//               Container(
//                 width: 36.w,
//                 height: 36.w,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: AppColors.greyF5,
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 child: AppSvgIcon(
//                   path: network.logoAsset,
//                   width: 20.w,
//                   height: 20.w,
//                 ),
//               ),
//               SizedBox(width: 10.w),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     network.name,
//                     style: context.textTheme.bodyMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     maskPhoneNumber(phoneNumber),
//                     style: context.textTheme.bodySmall?.copyWith(
//                       color: AppColors.grey80,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Divider(height: 28.h, color: AppColors.greyEE),
//           _row(
//             context,
//             'Airtime to sell',
//             '₦${amountToSell.toStringAsFixed(0)}',
//           ),
//           _row(
//             context,
//             'Conversion rate',
//             '${network.conversionRatePercent.round()}%',
//           ),
//           SizedBox(height: 8.h),
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("You'll receive", style: context.textTheme.bodyMedium),
//                 Text(
//                   '₦${amountToReceive.toStringAsFixed(0)}',
//                   style: context.textTheme.titleLarge?.copyWith(
//                     color: AppColors.primaryColor,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20.h),
//           BundlegramButton(
//             text: 'Confirm Conversion',
//             width: double.infinity,
//             onPressed: () {
//               Navigator.of(context, rootNavigator: true).pop(true);
//             },
//           ),
//           SizedBox(height: 8.h),
//           TextButton(
//             onPressed: () =>
//                 Navigator.of(context, rootNavigator: true).pop(false),
//             child: Text(
//               '< Go Back',
//               style: context.textTheme.bodyMedium?.copyWith(
//                 color: AppColors.grey33,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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

  static Future<bool?> show(
    BuildContext context, {
    required NetworkConfig network,
    required String phoneNumber,
    required double amountToSell,
    required double amountToReceive,
  }) async {
    return context.showPopUp<bool>(
      ConfirmTransactionDialog(
        network: network,
        phoneNumber: phoneNumber,
        amountToSell: amountToSell,
        amountToReceive: amountToReceive,
      ),
    );
  }

  Widget _row(BuildContext context, String label, Widget value) {
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
          value,
        ],
      ),
    );
  }

  Widget _textValue(BuildContext context, String value, {Color? color}) {
    return Text(
      value,
      style: context.textTheme.bodyMedium?.copyWith(
        color: color,
        fontWeight: FontWeight.w600,
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
          // Header: back arrow, title, close — matching the screenshot's
          // three-part row rather than the previous single left-aligned title.
          Row(
            children: [
              GestureDetector(
                onTap: () =>
                    Navigator.of(context, rootNavigator: true).pop(false),
                child: Icon(
                  Icons.arrow_back,
                  size: 20.sp,
                  color: AppColors.grey33,
                ),
              ),
              Expanded(
                child: Text(
                  'Conversion Summary',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context, rootNavigator: true).pop(null),
                child: Icon(Icons.close, size: 20.sp, color: AppColors.grey33),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Large centered credited amount — this is amountToReceive, not
          // the sell amount, per the screenshot ("₦800" for a ₦1,000 sell
          // at 80%).
          Text(
            '₦${amountToReceive.toStringAsFixed(0)}',
            style: context.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Amount to be credited to your wallet',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey80,
            ),
          ),
          SizedBox(height: 20.h),

          // Bordered info box with the five fields, in the screenshot's order.
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.greyF5,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _row(
                  context,
                  'Transaction',
                  _textValue(context, 'Airtime to Cash'),
                ),
                const Divider(height: 1, color: AppColors.greyEE),
                _row(
                  context,
                  'Network',
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSvgIcon(
                        path: network.logoAsset,
                        width: 18.w,
                        height: 18.w,
                      ),
                      SizedBox(width: 6.w),
                      _textValue(context, network.name),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.greyEE),
                _row(
                  context,
                  'Airtime to Transfer',
                  _textValue(context, '₦${amountToSell.toStringAsFixed(0)}'),
                ),
                const Divider(height: 1, color: AppColors.greyEE),
                _row(
                  context,
                  'Conversion Rate',
                  _textValue(
                    context,
                    '${network.conversionRatePercent.toStringAsFixed(0)}%',
                    color: AppColors.success,
                  ),
                ),
                const Divider(height: 1, color: AppColors.greyEE),
                _row(
                  context,
                  'Sender Phone',
                  _textValue(context, maskPhoneNumber(phoneNumber)),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          BundlegramButton(
            text: 'Proceed to Transfer',
            width: double.infinity,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(true),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
