import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_input_formatter.dart';
import 'package:bundlegram/data/models/banks/get_all_users_banks_response.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/withdraw_from_wallet_provider.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  ConsumerState<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends ConsumerState<WithdrawalScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the screen loads
    ref.read(withdrawalProvider).fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(withdrawalProvider);
    final globalUserProvider = ref.watch(globalProvider).profile;
    final profileProv = globalUserProvider.value?.data;

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Withdraw from wallet',
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                AppDropdown(
                  title: provider.selectedBank != null
                      ? 'Account ${provider.userBanks.indexOf(provider.selectedBank!) + 1}'
                      : 'Select account',
                  options: provider.userBanks
                      .asMap()
                      .entries
                      .map((entry) =>
                          'Account ${entry.key + 1} - ${entry.value.accountName ?? ''}')
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final index = int.parse(value
                              .split(' - ')[0]
                              .replaceFirst('Account ', '')) -
                          1;
                      provider.setSelectedBank(provider.userBanks[index]);
                    }
                  },
                ),
                24.verticalSpace,
                // Text(
                //   'Account ID: ${provider.selectedBank?.id ?? ''}',
                // ).withContainer(
                //   width: context.width,
                //   color: AppColors.greyD0.withOpacity(0.3),
                //   padding: context.symmetricPadding(24, 22),
                //   borderRadius: BorderRadius.circular(8),
                //   border: Border.all(color: AppColors.greyD0),
                // ),
                // 24.verticalSpace,
                Text(
                  provider.selectedBank?.bankName ?? '',
                ).withContainer(
                  width: context.width,
                  color: AppColors.greyD0.withOpacity(0.3),
                  padding: context.symmetricPadding(16, 12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.greyD0),
                ),
                24.verticalSpace,
                Text(
                  provider.selectedBank?.accountNumber ?? '',
                ).withContainer(
                  width: context.width,
                  color: AppColors.greyD0.withOpacity(0.3),
                  padding: context.symmetricPadding(16, 12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.greyD0),
                ),
                24.verticalSpace,
                Text(
                  provider.selectedBank?.accountName ?? '',
                ).withContainer(
                  width: context.width,
                  color: AppColors.greyD0.withOpacity(0.3),
                  padding: context.symmetricPadding(16, 12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.greyD0),
                ),
                24.verticalSpace,
                AppTextField(
                  hintText: 'Enter amount',
                  controller: provider.amountController,
                  inputFormatters: [CurrencyTextInputFormatter()],
                  keyboardType: TextInputType.number,
                  readOnly: profileProv?.bvn == null ? true : false,
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
                      style: context.textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Text(
                      provider.formattedBalance,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                40.verticalSpace,
                BundlegramButton(
                  isEnabled: profileProv?.bvn == null ? false : true,
                  text: provider.isSubmitting
                      ? "Requesting"
                      : 'Request withdrawal',
                  isLoading: provider.isSubmitting,
                  onPressed: provider.amountController.text.isEmpty
                      ? null
                      : () async {
                          final isValid = await provider
                              .validateAndPrepareWithdrawal(context);
                          if (!isValid) return;
                          unawaited(Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => EnterPinScreen(
                                onVerified: (pin) async {
                                  final success = await provider
                                      .requestWithdrawal(context, pin);
                                  if (!success) return;
                                  unawaited(Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => TransactionSuccessful(
                                        title: 'Withdrawal request received!',
                                        subTitle:
                                            'Your withdrawal request of ${provider.amountController.text.toCurrency()} from your Bundlegram wallet has been successfully received.',
                                      ),
                                    ),
                                  ));
                                },
                              ),
                            ),
                          ));
                        },
                ),
              ],
            ),
    );
  }
}
