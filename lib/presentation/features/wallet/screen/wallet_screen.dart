import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/recenttransaction_widget.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_transactions_notifier.dart';
// import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/async_value/app_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(walletServiceHistoryProvider('wallet').notifier).refresh();
    });
  }

  bool _isProcessing = false;

  Future<void> _handleFundWallet(BuildContext context) async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    final profile = ref.read(globalProvider).profile;
    final bvn = profile.value?.data?.bvn;

    if (bvn == null) {
      // WalletNotifier().showLinkBVNSnackBar(
      //   context,
      //   'BVN verification required to withdraw from your wallet.',
      //   'Link now',
      // );
      // unawaited(WalletNotifier().showAddMoneyViaDebitCard(context));
      await WalletNotifier().showAddMoney(context, ref);
    } else {
      await WalletNotifier().showAddMoney(context, ref);
    }

    if (mounted) {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(platformProvider);

    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        showBackButton: false,
        titleText: 'Wallet',
        trailing: GestureDetector(
          onTap: () => context.push(RouteConstants.walletHistoryScreen),
          child: Text(
            'History',
            style: context.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.showLoadingDialog();
          try {
            await Future.wait([
              ref.read(globalProvider.notifier).fetchWalletBalance(context),
              ref.read(globalProvider.notifier).fetchUsersTransactions(context),
            ]);
            ref.read(walletServiceHistoryProvider('wallet').notifier).refresh();
          } finally {
            context.dismissDialog();
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Wallet balance',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            8.horizontalSpace,
                            GestureDetector(
                              onTap: () => ref
                                  .read(platformProvider.notifier)
                                  .toggleBalanceVisibility(),
                              child: Icon(
                                provider.isBalanceVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              child: BundlegramButton(
                                width: 105.w,
                                height: 40.h,
                                color: AppColors.white,
                                cornerRadius: 4.r,
                                text: 'Withdraw',
                                textStyle:
                                    context.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 16.sp,
                                ),
                                onPressed: () {
                                  final profile =
                                      ref.read(globalProvider).profile;
                                  final bvn = profile.value?.data?.bvn;

                                  if (bvn == null) {
                                    WalletNotifier().showLinkBVNSnackBar(
                                      context,
                                      'BVN verification required to withdraw from your wallet.',
                                      'Link now',
                                    );
                                  } else {
                                    context.push(RouteConstants.withdrawFund);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          provider.isBalanceVisible
                              ? provider.formattedBalance
                              : '⁕⁕⁕⁕',
                          // wallet.value?.wallet.toCurrency() ?? '₦0.00',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontSize: provider.isBalanceVisible ? 34 : 24,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        16.verticalSpace,
                        Row(
                          children: [
                            Text(
                              'Promo rewards',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            8.horizontalSpace,
                            GestureDetector(
                              onTap: () => ref
                                  .read(platformProvider.notifier)
                                  .toggleBalanceVisibility(),
                              child: Icon(
                                provider.isBalanceVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          provider.isBalanceVisible ? "₦0.00" : '⁕⁕⁕⁕',
                          // wallet.value?.wallet.toCurrency() ?? '₦0.00',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontSize: provider.isBalanceVisible ? 34 : 24,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Assets.images.growth.image(),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   left: 0,
                  //   right: 0,
                  //   child: SizedBox(
                  //     // height: 100.h, // Set a specific height
                  //     child: Align(
                  //       alignment: Alignment.bottomCenter,
                  //       child: Assets.images.growth.image(),
                  //     ),
                  //   ),
                  // ),
                ],
              ).withContainer(
                color: AppColors.primaryColor,
                height: 360.h,
                width: context.width,
              ),
              32.verticalSpace,
              BundlegramButton(
                svgIconContainerColor: Colors.transparent,
                leading: Assets.svgs.walletAdd,
                text: 'Top-up wallet',
                onPressed:
                    _isProcessing ? null : () => _handleFundWallet(context),
              ),
              40.verticalSpace,
              // if (walletTxns == null || walletTxns.isEmpty)
              //   const Padding(
              //     padding: EdgeInsets.symmetric(vertical: 32),
              //     child: Center(child: EmptytransactionWidget()),
              //   )
              // else
              //   RecentTransactionWidget(
              //     SizedBox(height: 30),
              //     title: "Wallet Transactions",
              //     transactionProvider: walletTransactionsProvider,
              //   ),
              // ✅ Wrapped transactions with AppAsyncBuilder
              AppAsyncBuilder(
                state: ref
                    .watch(globalProvider.select((g) => g.usersTransactions)),
                onRetry: () async {
                  await Future.wait([
                    ref
                        .read(globalProvider.notifier)
                        .fetchWalletBalance(context),
                    ref
                        .read(globalProvider.notifier)
                        .fetchUsersTransactions(context),
                  ]);
                  ref
                      .read(walletServiceHistoryProvider('wallet').notifier)
                      .refresh();
                },
                builder: (context, ref, txnsResponse) {
                  final walletTxns = txnsResponse?.data?.where((txn) {
                    final type = txn.transType?.toLowerCase() ?? '';
                    return type == 'fund_wallet' || type == 'withdrawal';
                  }).toList();

                  if (walletTxns == null || walletTxns.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(child: EmptytransactionWidget()),
                    );
                  }

                  return RecentTransactionWidget(
                    SizedBox(height: 30),
                    title: "Wallet Transactions",
                    transactionProvider: walletTransactionsProvider,
                  );
                },
              ),
              35.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
