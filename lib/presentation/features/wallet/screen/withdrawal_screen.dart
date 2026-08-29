import 'dart:async';
import 'dart:convert';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/responsive_extensions.dart';
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
import 'package:bundlegram/presentation/features/transaction/screens/widgets/withdrawal_preview.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/withdraw_from_wallet_provider.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:bundlegram/presentation/general_widget/async_value/app_error_wiget.dart';
import 'package:bundlegram/services/notification_services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  ConsumerState<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends ConsumerState<WithdrawalScreen>
    with RestorationMixin, WidgetsBindingObserver {
  @override
  String? get restorationId => 'withdrawal_screen';

  final RestorableTextEditingController _restorableAmount =
      RestorableTextEditingController();

  bool _syncingFromProviderToRestorable = false;
  bool _syncingFromRestorableToProvider = false;
  bool _hasInitializedSync = false;
  bool _didInitialFetch = false;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_restorableAmount, 'amount');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _hasInitializedSync) return;
      _hasInitializedSync = true;

      Future.microtask(() async {
        final notifier = ref.read(withdrawalProvider);

        debugPrint('[WithdrawalScreen] restoreState: starting fetch');

        await notifier.fetchData(context);

        if (notifier.selectedBank == null && notifier.userBanks.isNotEmpty) {
          notifier.setSelectedBank(notifier.userBanks.first);
        }

        _initializeSync();
        notifier.setSubmitting(false);

        debugPrint('[WithdrawalScreen] restoreState: finished init sync.');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _didInitialFetch) return;
      _didInitialFetch = true;

      final provider = ref.read(withdrawalProvider);

      debugPrint('[WithdrawalScreen] Initial fetch');
      provider.fetchData(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;

    final provider = ref.read(withdrawalProvider);

    if (provider.userBanks.isNotEmpty &&
        provider.selectedBank != null &&
        provider.amountController.text.isNotEmpty) {
      debugPrint(
          '[WithdrawalScreen] Resume: state already hydrated, skipping fetch');
      return;
    }

    debugPrint('[WithdrawalScreen] Resume: missing data → refetching');
    Future.microtask(() => provider.fetchData(context));
  }

  void _initializeSync() {
    final provider = ref.read(withdrawalProvider);

    _wireTextSync(provider.amountController, _restorableAmount);

    final restoredText = _restorableAmount.value.text;
    if (restoredText.isNotEmpty &&
        provider.amountController.text != restoredText) {
      provider.amountController.text = restoredText;
    }
  }

  void _wireTextSync(
    TextEditingController providerCtrl,
    RestorableTextEditingController restorable,
  ) {
    final restCtrl = restorable.value;

    try {
      restCtrl.removeListener(() {});
    } catch (_) {}

    restCtrl.addListener(() {
      if (_syncingFromProviderToRestorable) return;

      void doSync() {
        if (!mounted) return;
        try {
          final restored = restCtrl.text;
          final providerText = providerCtrl.text;
          if (providerText != restored) {
            _syncingFromRestorableToProvider = true;
            providerCtrl.text = restored;
            _syncingFromRestorableToProvider = false;
          }
        } catch (e, st) {
          debugPrint('restorable->provider sync error: $e\n$st');
        }
      }

      if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
        WidgetsBinding.instance.addPostFrameCallback((_) => doSync());
      } else {
        doSync();
      }
    });

    providerCtrl.addListener(() {
      if (_syncingFromRestorableToProvider) return;
      try {
        final providerText = providerCtrl.text;
        final restorableText = restCtrl.text;
        if (restorableText != providerText) {
          _syncingFromProviderToRestorable = true;
          restCtrl.text = providerText;
          _syncingFromProviderToRestorable = false;
        }
      } catch (e, st) {
        debugPrint('provider->restorable sync error: $e\n$st');
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _restorableAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(
      globalProvider.select((g) => g.profile),
    );

    return BundlegramScaffold(
      useResponsive: true,
      resizeToAvoidBottomInset: true,
      appBar: const BundlegramAppbar(
        titleText: 'Withdraw from wallet',
      ),
      body: profileAsync.when(
        data: (_) {
          return const WithdrawalBody();
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, st) => AppErrorWidget(
          error: e,
          errorMessage: 'Unable to load profile details',
          onRetry: () {
            ref.read(globalProvider.notifier).fetchProfile(context);
          },
        ),
      ),
    );
  }
}

class WithdrawalBody extends ConsumerWidget {
  const WithdrawalBody({super.key});

  void _showWithdrawalPreview(
    BuildContext context,
    WidgetRef ref,
    WithdrawalProvider provider,
    dynamic profileProv,
  ) {
    context.showBottomSheet(
      showIcon: true,
      child: WithdrawalPreview(
        amount: provider.amountController.text,
        accountName: provider.selectedBank?.accountName ?? '',
        accountNumber: provider.selectedBank?.accountNumber ?? '',
        bankName: provider.selectedBank?.bankName ?? '',
        transactionFee: '100.0',
        onPay: () {
          context.pop(); // Close the preview
          _handleWithdrawal(
            context,
            ref,
            provider,
            profileProv,
          );
        },
      ),
    );
  }

  Future<void> _handleWithdrawal(
    BuildContext context,
    WidgetRef ref,
    WithdrawalProvider provider,
    dynamic profileProv,
  ) async {
    final isValid = await provider.validateAndPrepareWithdrawal(context);
    if (!isValid) return;

    final biometricService = ref.read(biometricServiceProvider);
    final isBiometricEnabled =
        await biometricService.isBiometricTransactionEnabled;

    if (isBiometricEnabled) {
      final didAuth = await biometricService.authenticate(
        type: BiometricAuthType.transaction,
        biometricHint: "",
        biometricRequiredTitle: "",
      );

      if (didAuth) {
        final email =
            await ref.read(secureStorageHelperProvider).getRememberedEmail();
        if (email == null) {
          debugPrint("No login email found, please login again");
          return;
        }

        final storedPin =
            await ref.read(secureStorageHelperProvider).getPin(email);
        if (storedPin == null) {
          debugPrint("No stored PIN found, please set up your PIN");
          return;
        }

        final message = await provider.requestWithdrawal(context, storedPin);
        if (message == null) return;

        context.go(
          RouteConstants.transactionSuccess,
          extra: TransactionSuccessArgs(
            title: 'Withdrawal request received!',
            subTitle: message,
          ),
        );
        return;
      } else {
        context.showErrorSnackBar("Biometric authentication cancelled");
      }
    }

    // Fallback to PIN entry
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => EnterPinScreen(
            onVerified: (pin) async {
              final message = await provider.requestWithdrawal(ctx, pin);
              if (message == null) return;

              final notifPayload = jsonEncode({
                'route': RouteConstants.transactionSuccess,
                'type': 'withdraw',
                'message': message,
                'amount': provider.amountController.text,
              });

              final notifId =
                  DateTime.now().millisecondsSinceEpoch.remainder(100000);

              unawaited(
                NotificationService().showNotification(
                  id: notifId,
                  title: 'Withdrawal request',
                  body:
                      'You initiated a withdrawal of ${provider.amountController.text.toCurrency()}',
                  payload: notifPayload,
                ),
              );

              unawaited(
                Navigator.pushReplacement(
                  ctx,
                  MaterialPageRoute(
                    builder: (ctx) => TransactionSuccessful(
                      title: 'Withdrawal request received!',
                      subTitle: message,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool _isAmountValid(String text) {
    if (text.isEmpty) return false;
    final amount = double.tryParse(text.replaceAll(',', ''));
    if (amount == null || amount <= 0) return false;
    if (amount < 500) return false;

    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final provider = ref.watch(withdrawalProvider);
    final globalUserProvider = ref.watch(globalProvider).profile;
    final profileProv = globalUserProvider.value?.data;
    String withdrawalServiceCharge = "100.0";
    // Rebuild on text change

    ref.listen<WithdrawalProvider>(
      withdrawalProvider,
      (previous, next) {
        if (previous?.amountController != next.amountController) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.microtask(() {
              if (context.mounted) {
                // Trigger sync if needed
              }
            });
          });
        }
      },
    );

    // Calculate if button should be enabled
    final isAmountValid = _isAmountValid(provider.amountController.text);
    final hasSelectedBank = provider.selectedBank != null;
    final hasBvn = profileProv?.bvn != null;
    final isButtonEnabled =
        // hasBvn ||
        hasSelectedBank && isAmountValid && !provider.isSubmitting;

    return provider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () async {
              await provider.fetchData(context);
            },
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: r.spacing(16), vertical: r.spacing(16)),
              children: [
                AppDropdown(
                  selected: provider.selectedBank != null
                      ? 'Account ${provider.userBanks.indexOf(provider.selectedBank!) + 1} - '
                          '${provider.selectedBank!.accountName ?? ''}'
                      : null,
                  title: provider.selectedBank != null
                      ? 'Account ${provider.userBanks.indexOf(provider.selectedBank!) + 1}'
                      : 'Select account',
                  options: provider.userBanks
                      .asMap()
                      .entries
                      .map(
                        (entry) =>
                            'Account ${entry.key + 1} - ${entry.value.accountName ?? ''}',
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;

                    final index = int.parse(value
                            .split(' - ')[0]
                            .replaceFirst('Account ', '')) -
                        1;

                    provider.setSelectedBank(provider.userBanks[index]);
                  },
                ),
                SizedBox(height: r.spacing(24)),
                Text(
                  provider.selectedBank?.bankName ?? '',
                ).withContainer(
                  width: context.width,
                  color: AppColors.greyD0.withOpacity(0.3),
                  padding:
                      context.symmetricPadding(r.spacing(16), r.spacing(12)),
                  borderRadius: BorderRadius.circular(r.radiusSize(8)),
                  border: Border.all(color: AppColors.greyD0),
                ),
                SizedBox(height: r.spacing(24)),
                Text(
                  provider.selectedBank?.accountNumber ?? '',
                ).withContainer(
                  width: context.width,
                  color: AppColors.greyD0.withOpacity(0.3),
                  padding:
                      context.symmetricPadding(r.spacing(16), r.spacing(12)),
                  borderRadius: BorderRadius.circular(r.radiusSize(8)),
                  border: Border.all(color: AppColors.greyD0),
                ),
                SizedBox(height: r.spacing(24)),
                Text(
                  provider.selectedBank?.accountName ?? '',
                ).withContainer(
                  width: context.width,
                  color: AppColors.greyD0.withOpacity(0.3),
                  padding:
                      context.symmetricPadding(r.spacing(16), r.spacing(12)),
                  borderRadius: BorderRadius.circular(r.radiusSize(8)),
                  border: Border.all(color: AppColors.greyD0),
                ),
                SizedBox(height: r.spacing(24)),
                AppTextField(
                  hintText: 'Enter amount',
                  controller: provider.amountController,
                  inputFormatters: [CurrencyTextInputFormatter()],
                  keyboardType: TextInputType.number,
                  readOnly: profileProv?.bvn == null ? true : false,
                  validateFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Amount is required';
                    }
                    final amount = double.tryParse(value.replaceAll(',', ''));
                    if (amount == null || amount <= 0) {
                      return 'Enter a valid amount';
                    }
                    if (amount < 500) {
                      return 'Minimum withdrawal amount is 500';
                    }
                    return null;
                  },
                ),
                SizedBox(height: r.spacing(16)),
                Row(
                  children: [
                    Container(
                      width: r.spacing(6),
                      height: r.spacing(6),
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
                SizedBox(height: r.spacing(8)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: r.spacing(12)),
                  padding: EdgeInsets.all(r.spacing(12)),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tooltip(
                        preferBelow: false,
                        message: 'Withdrawal service charge information',
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        showDuration: const Duration(seconds: 3),
                        textStyle: const TextStyle(
                          fontSize: 10,
                          color: AppColors.white,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        triggerMode: TooltipTriggerMode.tap,
                        child: const Icon(
                          Icons.info_outline,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(width: r.spacing(8)),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.dateColor,
                              fontSize: 12,
                            ),
                            children: [
                              const TextSpan(
                                  text: 'Note: A service charge of '),
                              TextSpan(
                                text: withdrawalServiceCharge.toCurrency(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const TextSpan(
                                  text: ' applies to each withdrawal.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: r.spacing(40)),
                // BundlegramButton(
                //   useResponsive: true,
                //   isEnabled: isButtonEnabled,
                //   text: provider.isSubmitting
                //       ? "Requesting"
                //       : 'Request withdrawal',
                //   isLoading: provider.isSubmitting,
                //   onPressed: isButtonEnabled
                //       ? () => _handleWithdrawal(
                //             context,
                //             ref,
                //             provider,
                //             profileProv,
                //           )
                //       : null,
                // ),
                // ValueListenableBuilder<TextEditingValue>(
                //   valueListenable: provider.amountController,
                //   builder: (_, value, __) {
                //     final isAmountValid = _isAmountValid(value.text);
                //     final isButtonEnabled = provider.selectedBank != null &&
                //         isAmountValid &&
                //         !provider.isSubmitting;

                //     return BundlegramButton(
                //       isEnabled: isButtonEnabled,
                //       onPressed: isButtonEnabled
                //           ? () => _handleWithdrawal(
                //               context, ref, provider, profileProv)
                //           : null,
                //       text: provider.isSubmitting ? "Requesting" : 'Withdraw',
                //       isLoading: provider.isSubmitting,
                //     );
                //   },
                // ),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: provider.amountController,
                  builder: (_, value, __) {
                    final isAmountValid = _isAmountValid(
                      value.text,
                    );
                    final isButtonEnabled = provider.selectedBank != null &&
                        isAmountValid &&
                        !provider.isSubmitting;

                    return BundlegramButton(
                      isEnabled: isButtonEnabled,
                      onPressed: isButtonEnabled
                          ? () => _showWithdrawalPreview(
                                context,
                                ref,
                                provider,
                                profileProv,
                              )
                          : null,
                      text: 'Continue',
                      isLoading: provider.isSubmitting,
                    );
                  },
                ),
              ],
            ),
          );
  }
}
