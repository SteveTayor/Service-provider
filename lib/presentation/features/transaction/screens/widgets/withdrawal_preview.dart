import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WithdrawalPreview extends StatelessWidget {
  const WithdrawalPreview({
    required this.amount,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.onPay,
    this.transactionFee = '100.0',
    super.key,
  });

  final String amount;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String transactionFee;
  final VoidCallback onPay;

  Widget _buildSummaryRow(String label, String value, {bool isCharge = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label - takes up to 40% of available width
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.grey83,
                fontSize: 12.sp,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
            ),
          ),

          8.horizontalSpace,

          // Value - takes remaining space
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyle(
                color: isCharge ? AppColors.errorText : AppColors.grey33,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total amount (amount + fee)
    final amountValue = double.tryParse(amount.replaceAll(',', '')) ?? 0.0;
    final feeValue = double.tryParse(transactionFee.replaceAll(',', '')) ?? 0.0;
    final totalAmount = (amountValue).toCurrency();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header - Fixed at top
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Withdrawal Summary',
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => context.pop(),
                      child: AppSvgIcon(path: Assets.svgs.close),
                    ),
                  ],
                ),
                8.verticalSpace,
                Divider(color: AppColors.divider),
              ],
            ),
          ),

          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  16.verticalSpace,

                  // Amount Display
                  Text(
                    amount.toCurrency(),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  8.verticalSpace,

                  // Text(
                  //   'Withdrawal Amount',
                  //   style: context.textTheme.bodySmall?.copyWith(
                  //     color: AppColors.grey83,
                  //   ),
                  // ),

                  18.verticalSpace,

                  // Transaction Details
                  _buildSummaryRow('Bank Name', bankName),
                  4.verticalSpace,
                  _buildSummaryRow('Account Number', accountNumber),
                  4.verticalSpace,
                  _buildSummaryRow('Beneficiary', accountName),
                  4.verticalSpace,
                  _buildSummaryRow('Amount', amount.toCurrency()),
                  4.verticalSpace,
                  _buildSummaryRow(
                    'Transaction Fee',
                    transactionFee.toCurrency(),
                    isCharge: true,
                  ),

                  8.verticalSpace,

                  Divider(color: AppColors.divider, thickness: 1),

                  8.verticalSpace,

                  // Total Amount
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Total',
                            style: TextStyle(
                              color: AppColors.grey33,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          flex: 3,
                          child: Text(
                            totalAmount,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColors.grey33,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  20.verticalSpace,
                ],
              ),
            ),
          ),

          // Fixed button at bottom
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 16.h,
              bottom: MediaQuery.of(context).padding.bottom + 16.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BundlegramButton(
              text: 'Confirm',
              onPressed: onPay,
            ),
          ),
        ],
      ),
    );
  }
}
