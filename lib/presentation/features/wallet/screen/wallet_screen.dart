import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/recenttransaction_widget.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/receipt_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
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
  bool isDismissed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(walletHistoryProvider.notifier).loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        showBackButton: false,
        titleText: 'Wallet',
        trailing: GestureDetector(
          onTap: () {
            context.push('/walletHistoryScreen');
          },
          child: Text(
            'History',
            style: context.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                          Flexible(
                            child: BundlegramButton(
                              width: 105.w,
                              height: 50.h,
                              color: AppColors.white,
                              cornerRadius: 4.r,
                              text: 'Withdraw',
                              textStyle: context.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.primaryColor),
                              onPressed: () {
                                context.push(RouteConstants.withdrawFund);
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'N40,000',
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
              height: 328.h,
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
            45.verticalSpace,
            RecenttransactionWidget(
              SizedBox(
                height: 20.h,
              ),
            ),
            // ..._buildWalletRecentTransactions(),
          ],
        ),
      ),
    );
  }
}
