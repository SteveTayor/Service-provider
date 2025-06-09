import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TransactionSummary extends StatelessWidget {
  const TransactionSummary({
    required this.amount,
    required this.paymentMethod,
    required this.beneficiary,
    required this.onPay,
    super.key,
    this.transactionType,
    this.discountedPrice,
    this.assetPath,
    this.imagePath,
  });
  final String amount;
  final String? transactionType;
  final String? discountedPrice;
  final String paymentMethod;
  final String beneficiary;
  final VoidCallback onPay;
  final String? assetPath;
  final String? imagePath;

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.grey83,
              fontSize: 14.sp,
            ),
          ),
          Row(
            children: [
              if (imagePath != null)
                Image.asset(
                  imagePath!,
                  width: 24.w,
                  height: 24.w,
                  fit: BoxFit.contain,
                )
              else
                AppSvgIcon(
                  path: assetPath!,
                  fit: BoxFit.scaleDown,
                ),
              8.horizontalSpace,
              Text(
                value,
                style: TextStyle(
                  color: AppColors.grey33,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                'Summary',
                style: context.textTheme.bodyMedium,
              ))),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: AppSvgIcon(path: Assets.svgs.close),
              ),
            ],
          ),
          32.verticalSpace,
          Text(
            amount,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.grey33,
            ),
          ),
          16.verticalSpace,
          if (transactionType != null)
            _buildSummaryRow('Transaction type', transactionType!),
          _buildSummaryRow('Amount', amount),
          if (discountedPrice != null)
            _buildSummaryRow('Discounted price', discountedPrice!),
          _buildSummaryRow('Payment method', paymentMethod),
          if (beneficiary.isNotEmpty)
            _buildSummaryRow('Beneficiary', beneficiary),
          24.verticalSpace,
          BundlegramButton(
            text: 'Pay',
            onPressed: () {
              context.push(RouteConstants.enterPin);
            },
          ),
        ],
      ),
    );
  }
}
