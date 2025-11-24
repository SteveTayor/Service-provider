import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_input_formatter.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/features/biometric/providers/biometric_service.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/model.dart';
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
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
    ref.read(withdrawalProvider).amountController.clear();
    ref.read(withdrawalProvider).setSubmitting(false);
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
          : AnimationLimiter(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 30.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    // Account Selection Dropdown
                    AppDropdown(
                      selected: provider.selectedBank != null
                          ? '${provider.selectedBank}'
                          : null,
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

                    SizedBox(height: 24.h),

                    // Bank Name Container
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        horizontalOffset: -30.0,
                        child: FadeInAnimation(
                          child: Text(
                            provider.selectedBank?.bankName ?? '',
                          ).withContainer(
                            width: context.width,
                            color: AppColors.greyD0.withOpacity(0.3),
                            padding: context.symmetricPadding(16, 12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.greyD0),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Account Number Container
                    AnimationConfiguration.staggeredList(
                      position: 2,
                      delay: const Duration(milliseconds: 200),
                      child: SlideAnimation(
                        horizontalOffset: 30.0,
                        child: FadeInAnimation(
                          child: Text(
                            provider.selectedBank?.accountNumber ?? '',
                          ).withContainer(
                            width: context.width,
                            color: AppColors.greyD0.withOpacity(0.3),
                            padding: context.symmetricPadding(16, 12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.greyD0),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Account Name Container
                    AnimationConfiguration.staggeredList(
                      position: 3,
                      delay: const Duration(milliseconds: 300),
                      child: SlideAnimation(
                        horizontalOffset: -30.0,
                        child: FadeInAnimation(
                          child: Text(
                            provider.selectedBank?.accountName ?? '',
                          ).withContainer(
                            width: context.width,
                            color: AppColors.greyD0.withOpacity(0.3),
                            padding: context.symmetricPadding(16, 12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.greyD0),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Amount Input Field
                    AnimationConfiguration.staggeredList(
                      position: 4,
                      delay: const Duration(milliseconds: 400),
                      child: ScaleAnimation(
                        scale: 0.8,
                        child: FadeInAnimation(
                          child: AppTextField(
                            hintText: 'Enter amount',
                            controller: provider.amountController,
                            inputFormatters: [CurrencyTextInputFormatter()],
                            keyboardType: TextInputType.number,
                            readOnly: profileProv?.bvn == null ? true : false,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Wallet Balance Row
                    AnimationConfiguration.staggeredList(
                      position: 5,
                      delay: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 20.0,
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(width: 6.w),
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
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Submit Button with Special Animation
                    AnimationConfiguration.staggeredList(
                      position: 6,
                      delay: const Duration(milliseconds: 600),
                      child: ScaleAnimation(
                        scale: 0.7,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 800),
                            child: BundlegramButton(
                              isEnabled:
                                  profileProv?.bvn == null ? false : true,
                              text: provider.isSubmitting
                                  ? "Requesting"
                                  : 'Request withdrawal',
                              isLoading: provider.isSubmitting,
                              onPressed: provider.amountController.text.isEmpty
                                  ? null
                                  : () async {
                                      final isValid = await provider
                                          .validateAndPrepareWithdrawal(
                                              context);
                                      if (!isValid) return;

                                      final biometricService =
                                          ref.read(biometricServiceProvider);
                                      final isBiometricEnabled =
                                          await biometricService
                                              .isBiometricTransactionEnabled;

                                      if (isBiometricEnabled) {
                                        final didAuth =
                                            await biometricService.authenticate(
                                          type: BiometricAuthType.transaction,
                                          biometricHint: "",
                                          biometricRequiredTitle: "",
                                        );

                                        if (didAuth) {
                                          final email = await ref
                                              .read(secureStorageHelperProvider)
                                              .getRememberedEmail();
                                          if (email == null) {
                                            debugPrint(
                                                "No login email found, please login again");
                                            return;
                                          }

                                          final storedPin = await ref
                                              .read(secureStorageHelperProvider)
                                              .getPin(email);
                                          if (storedPin == null) {
                                            debugPrint(
                                                "No stored PIN found, please set up your PIN");
                                            return;
                                          }

                                          final success =
                                              await provider.requestWithdrawal(
                                                  context, storedPin);
                                          if (!success) return;

                                          context.go(
                                            RouteConstants.transactionSuccess,
                                            extra: TransactionSuccessArgs(
                                              title:
                                                  'Withdrawal request received!',
                                              subTitle:
                                                  'Your withdrawal request of ${provider.amountController.text.toCurrency()} from your Bundlegram wallet has been successfully received.',
                                            ),
                                          );
                                          return;
                                        } else {
                                          context.showErrorSnackBar(
                                              "Biometric authentication cancelled");
                                        }
                                      }

                                      // Fallback to PIN entry
                                      unawaited(
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (ctx) => EnterPinScreen(
                                              onVerified: (pin) async {
                                                final success = await provider
                                                    .requestWithdrawal(
                                                        ctx, pin);
                                                if (!success) return;

                                                unawaited(
                                                  Navigator.pushReplacement(
                                                    ctx,
                                                    MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          TransactionSuccessful(
                                                        title:
                                                            'Withdrawal request received!',
                                                        subTitle:
                                                            'Your withdrawal request of ${provider.amountController.text.toCurrency()} from your Bundlegram wallet has been successfully received.',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
