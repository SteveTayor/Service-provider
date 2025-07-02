import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletoutlookWidget extends ConsumerWidget {
  const WalletoutlookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(platformProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Wallet balance ',
              style: context.textTheme.bodySmall!
                  .copyWith(fontSize: 16.sp, color: AppColors.white),
            ),
            GestureDetector(
              onTap: () =>
                  ref.read(platformProvider.notifier).toggleBalanceVisibility(),
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
        16.verticalSpace,
        Text(
          provider.isBalanceVisible ? provider.formattedBalance : '⁕⁕⁕⁕',
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: provider.isBalanceVisible ? 40.sp : 24.sp,
            color: AppColors.white,
          ),
        ),
        16.verticalSpace,
        BundlegramButton(
          width: 130.w,
          height: 50.h,
          color: AppColors.white,
          cornerRadius: 4.r,
          text: 'Fund wallet',
          textStyle: context.textTheme.bodyMedium!
              .copyWith(color: AppColors.primaryColor),
          onPressed: () {
            WalletNotifier().showAddMoney(context);
          },
        ),
      ],
    );
  }
}
