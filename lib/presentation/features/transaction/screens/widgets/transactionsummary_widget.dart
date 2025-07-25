import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TransactionSummary extends ConsumerWidget {
  const TransactionSummary({
    required this.amount,
    required this.paymentMethod,
    this.beneficiary,
    required this.onPay,
    super.key,
    this.transactionType,
    this.discountedPrice,
    this.assetPath,
    this.isBecomeAnAgent = false,
  });
  final String amount;
  final String? transactionType;
  final String? discountedPrice;
  final String paymentMethod;
  final String? beneficiary;
  final VoidCallback onPay;
  final String? assetPath;
  final bool isBecomeAnAgent;

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Label
              Expanded(
                flex: 2,
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.grey83,
                    // fontSize: 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Value + optional icon
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (label == 'Transaction type' && assetPath != null)
                      assetPath!.contains('.svg')
                          ? AppSvgIcon(
                              path: assetPath!,
                              fit: BoxFit.scaleDown,
                              width: 20.w,
                              height: 20.h,
                            )
                          : Image.asset(
                              assetPath!,
                              width: 20.w,
                              height: 20.h,
                              fit: BoxFit.scaleDown,
                            ),
                    if (label == 'Transaction type' && assetPath != null)
                      8.horizontalSpace,
                    Flexible(
                      child: Text(
                        value.contains('Buy')
                            ? value.replaceFirst('Buy', '').trim()
                            : value,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.grey33,
                          // fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletBalanceAsync =
        ref.watch(globalProvider.select((s) => s.walletBalance));
    final walletBalance = walletBalanceAsync.value?.wallet ?? 0.0;

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
              Flexible(
                child: Center(
                  child: Text(
                    'Summary',
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: AppSvgIcon(path: Assets.svgs.close),
              ),
            ],
          ),
          8.verticalSpace,
          Divider(
            color: AppColors.divider,
          ),
          12.verticalSpace,
          if (isBecomeAnAgent != true) ...[
            Text(
              discountedPrice ?? amount,
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.grey33,
              ),
            ),
            32.verticalSpace,
            if (transactionType != null) ...[
              _buildSummaryRow('Transaction type', transactionType!),
              8.verticalSpace,
            ],
            _buildSummaryRow('Amount', amount),
            8.verticalSpace,
            if (discountedPrice != null) ...[
              _buildSummaryRow('Discounted price', discountedPrice!),
              8.verticalSpace,
            ],
            _buildSummaryRow('Payment method', paymentMethod),
            8.verticalSpace,
            if (beneficiary!.isNotEmpty)
              _buildSummaryRow('Beneficiary', beneficiary!),
          ] else ...[
            Text(
              discountedPrice ?? amount,
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.grey33,
              ),
            ),
            32.verticalSpace,
            _buildSummaryRow('Transaction type', transactionType!),
            8.verticalSpace,
            _buildSummaryRow('Amount to pay', amount),
            8.verticalSpace,
            _buildSummaryRow('Payment method', paymentMethod),
            16.verticalSpace,
            Row(
              children: [
                AppSvgIcon(path: Assets.svgs.balance),
                8.horizontalSpace,
                Text('Balance (${CurrencyFormatter.format(walletBalance)})',
                    style: context.textTheme.bodySmall),
                const Spacer(),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      context.go(RouteConstants.dashboard);
                    },
                    child: Text(
                      'Top-up >',
                      style: context.textTheme.bodySmall!
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ],
            ).withContainer(
              color: const Color(0xffEEF3FF),
              padding: context.symmetricPadding(10, 8),
              borderRadius: BorderRadius.circular(6),
            ),
          ],
          24.verticalSpace,
          BundlegramButton(
            text: 'Pay',
            onPressed: onPay,
          ),
        ],
      ),
    );
  }
}
