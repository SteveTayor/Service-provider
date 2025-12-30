import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
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
    this.billValidatedName,
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
  final String? billValidatedName;

  Widget _buildSummaryRow(String label, String value) {
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
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
            ),
          ),

          8.horizontalSpace,

          // Value + optional icon - takes remaining space
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (label == 'Transaction type' && assetPath != null) ...[
                      assetPath!.contains('.svg')
                          ? AppSvgIcon(
                              path: assetPath!,
                              fit: BoxFit.scaleDown,
                              width: 20.w,
                              height: 20.h,
                              useCircleAvatar: true,
                            )
                          : Image.asset(
                              assetPath!,
                              width: 20.w,
                              height: 20.h,
                              fit: BoxFit.scaleDown,
                            ),
                      4.horizontalSpace,
                    ],
                    Flexible(
                      child: Text(
                        value.contains('Buy')
                            ? value.replaceFirst('Buy', '').trim()
                            : value,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          color: AppColors.grey33,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletBalanceAsync =
        ref.watch(globalProvider.select((s) => s.walletBalance));
    // Helper to safely convert various types (num, String like "₦1,000.00") to double
    double toDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      if (v is String) {
        final cleaned = v.replaceAll(
            RegExp(r'[^\d.]'), ''); // removes commas, currency symbols
        return double.tryParse(cleaned) ?? 0.0;
      }
      return 0.0;
    }

    // Handle error or loading states safely
    final walletBalance = walletBalanceAsync.maybeWhen(
      data: (balance) => toDouble(balance?.wallet),
      orElse: () => 0.0,
    );

    // final rawWallet = walletBalanceAsync.value?.wallet;
    // final walletBalance = toDouble(rawWallet);

    final amountValue = toDouble(amount);

    // now both are doubles — comparison is valid
    final isEnabled = walletBalance >= amountValue;

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
                          'Summary',
                          style: context.textTheme.bodyMedium,
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
                  12.verticalSpace,
                  if (isBecomeAnAgent != true) ...[
                    Text(
                      discountedPrice ?? amount,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    32.verticalSpace,
                    if (transactionType != null) ...[
                      _buildSummaryRow('Transaction type', transactionType!),
                      8.verticalSpace,
                    ],
                    _buildSummaryRow('Amount', amount),
                    8.verticalSpace,
                    if (billValidatedName != null) ...[
                      _buildSummaryRow('Name', billValidatedName!),
                      8.verticalSpace,
                    ],
                    if (discountedPrice != null) ...[
                      _buildSummaryRow('Discounted price', discountedPrice!),
                      8.verticalSpace,
                    ],
                    _buildSummaryRow('Payment method', paymentMethod),
                    8.verticalSpace,
                    if (beneficiary != null && beneficiary!.isNotEmpty)
                      _buildSummaryRow('Beneficiary', beneficiary!),
                  ] else ...[
                    Text(
                      discountedPrice ?? amount,
                      style: TextStyle(
                        fontSize: 32.sp, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey33,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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
                        Expanded(
                          child: Text(
                            'Balance (${walletBalance.toCurrency()})',
                            style: context.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        4.horizontalSpace,
                        InkWell(
                          onTap: () => context.go(RouteConstants.dashboard),
                          child: Text(
                            'Top-up >',
                            style: context.textTheme.bodySmall!
                                .copyWith(color: AppColors.primaryColor),
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
              text: 'Pay',
              onPressed: isEnabled ? onPay : null,
              isEnabled: isEnabled,
            ),
          ),
        ],
      ),
    );
  }
}
