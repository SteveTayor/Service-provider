import 'dart:async';

import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/async_value/app_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletoutlookWidget extends ConsumerStatefulWidget {
  const WalletoutlookWidget({super.key});

  @override
  ConsumerState<WalletoutlookWidget> createState() =>
      _WalletoutlookWidgetState();
}

class _WalletoutlookWidgetState extends ConsumerState<WalletoutlookWidget> {
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
      unawaited(WalletNotifier().showAddMoneyViaDebitCard(context));
    } else {
      await WalletNotifier().showAddMoney(context, ref);
    }

    if (mounted) {
      setState(() => _isProcessing = false);
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     final provider = ref.watch(platformProvider);
//     final profile = ref.watch(globalProvider).profile;
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Wallet balance ',
//               style: context.textTheme.bodyMedium!
//                   .copyWith(color: AppColors.white),
//             ),
//             GestureDetector(
//               onTap: () =>
//                   ref.read(platformProvider.notifier).toggleBalanceVisibility(),
//               child: Icon(
//                 provider.isBalanceVisible
//                     ? Icons.visibility
//                     : Icons.visibility_off,
//                 color: AppColors.white,
//                 size: 24,
//               ),
//             ),
//           ],
//         ),
//         12.verticalSpace,
//         Text(
//           provider.isBalanceVisible ? provider.formattedBalance : '⁕⁕⁕⁕',
//           style: context.textTheme.titleLarge!.copyWith(
//             fontSize: provider.isBalanceVisible ? 34 : 24,
//             fontWeight: FontWeight.w500,
//             color: AppColors.white,
//           ),
//         ),
//         16.verticalSpace,
//         BundlegramButton(
//           width: 130.w,
//           height: 40.h,
//           color: AppColors.white,
//           cornerRadius: 4.r,
//           text: 'Fund wallet',
//           textStyle: context.textTheme.bodyMedium!
//               .copyWith(color: AppColors.primaryColor),
//           onPressed: _isProcessing ? null : () => _handleFundWallet(context),
//         ),
//       ],
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(platformProvider);
    final walletBalance = ref.watch(globalProvider).walletBalance;
    final profile = ref.watch(globalProvider).profile;

    return Column(
      children: [
        // 👇 Wrap balance with AppAsyncBuilder
        AppAsyncBuilder(
          state: walletBalance,
          onRetry: () =>
              ref.read(globalProvider.notifier).fetchWalletBalance(context),
          builder: (context, ref, wallet) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Wallet balance ',
                      style: context.textTheme.bodyMedium!
                          .copyWith(fontSize: 16.sp, color: AppColors.white),
                    ),
                    GestureDetector(
                      onTap: () => ref
                          .read(platformProvider.notifier)
                          .toggleBalanceVisibility(),
                      child: Icon(
                        provider.isBalanceVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                Text(
                  provider.isBalanceVisible
                      ? provider.formattedBalance
                      : '⁕⁕⁕⁕',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontSize: provider.isBalanceVisible ? 34 : 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            );
          },
        ),

        16.verticalSpace,

        //  Profile-based button state
        AppAsyncBuilder(
          state: profile,
          onRetry: () =>
              ref.read(globalProvider.notifier).fetchProfile(context),
          builder: (context, ref, userProfile) {
            return BundlegramButton(
              width: 130.w,
              height: 40.h,
              color: AppColors.white,
              cornerRadius: 4.r,
              text: 'Fund wallet',
              textStyle: context.textTheme.bodyMedium!.copyWith(
                fontSize: 16.sp,
                color: AppColors.primaryColor,
              ),
              onPressed:
                  _isProcessing ? null : () => _handleFundWallet(context),
            );
          },
        ),
      ],
    );
  }
}
