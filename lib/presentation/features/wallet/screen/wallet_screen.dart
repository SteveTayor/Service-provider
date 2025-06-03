import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        showBackButton: false,
        titleText: 'Wallet',
        trailing: Text(
          'History',
          style: context.textTheme.bodySmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Wallet balance',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        8.horizontalSpace,
                        const Icon(
                          Icons.visibility,
                          size: 20,
                          color: AppColors.white,
                        ),
                        const Spacer(),
                        BundlegramButton(
                          // width: 130.w,
                          height: 50.h,
                          color: AppColors.white,
                          cornerRadius: 4.r,
                          text: 'Withdraw',
                          textStyle: context.textTheme.bodyMedium!
                              .copyWith(color: AppColors.primaryColor),
                          onPressed: () {
                            // WalletNotifier().showAddMoney(context);
                          },
                        ),
                      ],
                    ),
                    Text(
                      'N40,0000',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 40.sp,
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
            ],
          ).withContainer(
            color: AppColors.primaryColor,
            height: 400.h,
            width: context.width,
          ),
          32.verticalSpace,
          BundlegramButton(
            svgIconContainerColor: Colors.transparent,
            leading: Assets.svgs.walletAdd,
            text: 'Top-up wallet',
            onPressed: () {
              WalletNotifier().showAddMoney(context);
            },
          ),
        ],
      ),
    );
  }
}
