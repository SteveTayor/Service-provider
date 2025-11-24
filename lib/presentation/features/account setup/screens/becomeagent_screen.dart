import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/become_a_merchant_provider.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/animated_containers/animated_become_agent_benefits.dart'
    show AnimatedBenfitList;
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/verifyemail_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BecomeagentScreen extends ConsumerWidget {
  const BecomeagentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalUserProvider = ref.watch(globalProvider).profile;
    final profileProv = globalUserProvider.value?.data;

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Become an agent',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Replace the entire benefits section with this single widget
            AnimatedBenfitList(benefits: benefits),

            40.verticalSpace,
            BundlegramButton(
              isEnabled: profileProv?.userType != "agent",
              text: 'Continue',
              onPressed: profileProv?.userType == "agent"
                  ? null
                  : () {
                      context.showBottomSheet(
                        child: TransactionSummary(
                          isBecomeAnAgent: true,
                          transactionType: 'Agent fee',
                          amount: '₦10,000.00',
                          paymentMethod: 'Wallet',
                          onPay: () {
                            ref
                                .read(becomeAgentProvider.notifier)
                                .checkAndInitiatePayment(context);
                          },
                        ),
                      );
                    },
            ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}

// Keep your existing Benefit class and benefits list
class Benfit {
  final String asset;
  final String title;
  final String label;

  Benfit({required this.asset, required this.title, required this.label});
}

final List<Benfit> benefits = [
  Benfit(
    asset: Assets.svgs.union,
    title: 'Easy Onboarding Process',
    label:
        'No need to fill out forms or go through a verification process. Create an account instantly to start reselling airtime and data.',
  ),
  Benfit(
    asset: Assets.svgs.box,
    title: 'Discounts and Withdrawals',
    label:
        'Enjoy discounts on every data top-up and airtime top-up of all networks, with an instant settlement of all agent withdrawal transactions.',
  ),
  Benfit(
    asset: Assets.svgs.chartBarSquare,
    title: 'Monitor Your Business',
    label:
        'Our in-depth dashboards and advanced analytics offer complete visibility over every single aspect of your daily transactions, leaving no room for ambiguity.',
  ),
  Benfit(
    asset: Assets.svgs.call,
    title: '24/7 Customer Support',
    label:
        'Bundlegram provides 24/7 customer support to ensure success. Our support channels are always available to assist you.',
  ),
  Benfit(
    asset: Assets.svgs.banknotes,
    title: 'Earn More Money',
    label:
        'Become a Bundlegram agent and start making money on every transaction you make. With our low pricing, you can make money daily.',
  ),
  Benfit(
    asset: Assets.svgs.noapineeded,
    title: 'No API Required',
    label:
        'It\'s easy to become a Bundlegram agent - just create an account, complete KYC, and start selling airtime and data to your customers.',
  ),
];
