import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platform_screen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformbills_widget.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/onboarding_data.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformitem_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/widget/walletoutlook_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PlatformQuickActionWidget extends ConsumerWidget {
  const PlatformQuickActionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = ref.read(platformProvider);
    return Container(
      height: 480.h,
      width: context.width,
      color: AppColors.primaryColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image(
              image: Assets.images.shapes.provider(),
              fit: BoxFit.cover,
              repeat: ImageRepeat.repeat,
            ),
          ),
          Column(
            children: [
              25.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppSvgIcon(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    path: Assets.svgs.bars3,
                    width: 24.w,
                    fit: BoxFit.scaleDown,
                    height: 24.h,
                  ),
                  Text(
                    'Bundlegram',
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontSize: 20.sp, color: AppColors.white),
                  ),
                  AppSvgIcon(
                    onTap: () => platform.goToNotification(context),
                    path: Assets.svgs.notification,
                    width: 24.w,
                    fit: BoxFit.scaleDown,
                    height: 24.h,
                  ),
                ],
              ),
              50.verticalSpace,
              const WalletoutlookWidget(),
              41.verticalSpace,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PlatformItemWidget(
                      title: 'Buy data',
                      icon: Assets.svgs.mobile,
                      onPressed: () => platform.goToProduct(
                          context, PlatformProductType.mobileData),
                    ),
                    PlatformItemWidget(
                      title: 'Buy airtime',
                      icon: Assets.svgs.simcard2,
                      onPressed: () => platform.goToProduct(
                          context, PlatformProductType.airtime),
                    ),
                    PlatformItemWidget(
                      title: 'Pay bills',
                      icon: Assets.svgs.walletMinus,
                      onPressed: () => platform.openBillBottomSheet(context),
                    ),
                    PlatformItemWidget(
                      title: 'Withdraw',
                      icon: Assets.svgs.walletMoneyPaymentFinanceWallet,
                      onPressed: () => platform.goToWithdrawFund(context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: PlatformItemWidget(
                        title: 'Airtime 2 Cash',
                        iconData: Icons.currency_exchange,
                        onPressed: () => platform.goToAirtimeToCash(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).withContainer(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 30)),
        ],
      ),
    );
  }
}
