import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/enums.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PlatformQuickActionWidget extends StatelessWidget {
  const PlatformQuickActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
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
                    onTap: () {
                      context.push('/notification');
                    },
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PlatformItemWidget(
                    title: 'Buy data',
                    icon: Assets.svgs.mobile,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlatformproductScreen(
                            serviceType: PlatformProductType.mobileData,
                          ),
                        ),
                      );
                    },
                  ),
                  PlatformItemWidget(
                    title: 'Buy airtime',
                    icon: Assets.svgs.simcard2,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlatformproductScreen(
                            serviceType: PlatformProductType.airtime,
                          ),
                        ),
                      );
                    },
                  ),
                  PlatformItemWidget(
                    title: 'Pay bills',
                    icon: Assets.svgs.walletMinus,
                    onPressed: () {
                      context.showBottomSheet(
                        child: const PlatformbillsWidget(),
                      );
                    },
                  ),
                  PlatformItemWidget(
                    title: 'Withdraw',
                    icon: Assets.svgs.walletMoneyPaymentFinanceWallet,
                    onPressed: () {
                      context.push(RouteConstants.withdrawFund);
                    },
                  ),
                ],
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
