import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String amount = '₦10,500';
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Withdraw from wallet',
      ),
      body: Column(
        children: [
          const AppDropdown(title: 'Account 1'),
          24.verticalSpace,
          const Text('First Bank of Nigeria').withContainer(
            width: context.width,
            color: AppColors.greyD0.withOpacity(0.3),
            padding: context.symmetricPadding(24, 22),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.greyD0),
          ),
          24.verticalSpace,
          const Text('2200223344').withContainer(
            width: context.width,
            color: AppColors.greyD0.withOpacity(0.3),
            padding: context.symmetricPadding(24, 22),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.greyD0),
          ),
          24.verticalSpace,
          const Text('Rose Owen').withContainer(
            width: context.width,
            color: AppColors.greyD0.withOpacity(0.3),
            padding: context.symmetricPadding(24, 22),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.greyD0),
          ),
          24.verticalSpace,
          const AppTextField(
            hintText: 'Enter amount',
          ),
          16.verticalSpace,
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
              ),
              6.horizontalSpace,
              Text(
                'Wallet balance',
                style: context.textTheme.bodySmall,
              ),
              const Spacer(),
              Text(
                '20,000',
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          40.verticalSpace,
          BundlegramButton(
            text: 'Request withdrawal',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => EnterPinScreen(
                    onVerified: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => TransactionSuccessful(
                            title: 'Withdrawal request received! ',
                            subTitle:
                                'Your withdrawal request of ${amount} from your Bundlegram wallet has been successfully received.',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
