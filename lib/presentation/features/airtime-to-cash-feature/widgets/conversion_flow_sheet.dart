import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_input_formatter.dart';
import 'package:bundlegram/core/utils/phone_mask.dart';

import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/model/airtime_to_cash_state.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_provider.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/airtime_share_pin_info_dialog.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/confirm_transaction_dialog.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/network_selector_grid.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/otp_input_row.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/result_status_dialog.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Guards against the sheet being opened more than once at a time.
bool _isConversionSheetOpen = false;

/// Opens the Airtime-to-Cash conversion flow as a bottom sheet.
Future<void> showAirtimeToCashConversionSheet(BuildContext context) async {
  if (_isConversionSheetOpen) return;
  _isConversionSheetOpen = true;
  try {
    await context.showBottomSheet(
      isDismissible: true,
      // showDragHandle: true,
      child: const ConversionFlowSheet(),
    );
  } finally {
    _isConversionSheetOpen = false;
  }
}

/// Which of the 4 broad stages a given [AirtimeToCashStep] belongs to, for
/// the header's step indicator ("Step 2 of 4" + dots).
int _stageFor(AirtimeToCashStep step) {
  switch (step) {
    case AirtimeToCashStep.networkSelection:
    case AirtimeToCashStep.noActiveConfig:
    case AirtimeToCashStep.phoneEntry:
    case AirtimeToCashStep.sendingOtp:
    case AirtimeToCashStep.balanceTooLow:
      return 1;
    case AirtimeToCashStep.otpEntry:
    case AirtimeToCashStep.verifyingOtp:
      return 2;
    case AirtimeToCashStep.enteringAmount:
    case AirtimeToCashStep.checkingQuota:
      return 3;
    case AirtimeToCashStep.confirming:
    case AirtimeToCashStep.submitting:
    case AirtimeToCashStep.success:
    case AirtimeToCashStep.processing:
    case AirtimeToCashStep.partial:
    case AirtimeToCashStep.failed:
      return 4;
  }
}

const _stageLabels = ['Network & Phone', 'OTP', 'Amount', 'Confirmation'];

class ConversionFlowSheet extends ConsumerStatefulWidget {
  const ConversionFlowSheet({super.key});

  @override
  ConsumerState<ConversionFlowSheet> createState() =>
      _ConversionFlowSheetState();
}

class _ConversionFlowSheetState extends ConsumerState<ConversionFlowSheet> {
  final _otpKey = GlobalKey<OtpInputRowState>();
  String _otpValue = '';

  Future<void> _handleResendOtp() async {
    final notifier = ref.read(airtimeToCashProvider.notifier);
    await notifier.resendOtp();
    if (!mounted) return;
    final state = ref.read(airtimeToCashProvider);
    // Only clear/refocus on success — don't wipe a possibly-still-valid
    // OTP entry out from under the user if the resend request failed.
    if (state.otpSendError == null) {
      _otpKey.currentState?.clear();
      setState(() => _otpValue = '');
    }
  }

  Future<void> _handleConfirmingStep(NetworkConfig network) async {
    final state = ref.read(airtimeToCashProvider);
    final amount = double.tryParse(
      state.amountController.text.replaceAll(RegExp(r'[^0-9.]'), ''),
    );
    if (amount == null) return;

    final confirmed = await ConfirmTransactionDialog.show(
      context,
      network: network,
      phoneNumber: state.phoneController.text.trim(),
      amountToSell: amount,
      amountToReceive: state.amountToReceive,
    );

    if (!mounted) return;
    final notifier = ref.read(airtimeToCashProvider.notifier);
    if (confirmed == true) {
      unawaited(notifier.confirmAndSubmit());
    } else {
      notifier.backToAmountEntry();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(airtimeToCashProvider);
    final notifier = ref.read(airtimeToCashProvider.notifier);

    ref.listen<AirtimeToCashState>(airtimeToCashProvider, (previous, next) {
      if (previous?.step == next.step) return;

      if (next.step == AirtimeToCashStep.confirming &&
          next.selectedNetwork != null) {
        _handleConfirmingStep(next.selectedNetwork!);
        return;
      }

      if (next.step == AirtimeToCashStep.success &&
          next.lastTransaction != null) {
        final txn = next.lastTransaction!;
        ResultStatusDialog.show(
          context,
          kind: ResultStatusKind.success,
          title: 'Conversion Successful',
          message:
              '₦${txn.amountReceived.toStringAsFixed(0)} has been added from your '
              '₦${txn.amountSold.toStringAsFixed(0)} airtime conversion.',
          primaryLabel: 'Done',
          onPrimaryPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).maybePop();
          },
        );
        return;
      }

      if (next.step == AirtimeToCashStep.processing &&
          next.lastTransaction != null) {
        final txn = next.lastTransaction!;
        ResultStatusDialog.show(
          context,
          kind: ResultStatusKind.processing,
          title: 'Conversion Processing',
          message:
              txn.failureReason ??
              'Your conversion is being processed. You will be credited once '
                  'the network confirms.',
          primaryLabel: 'Done',
          onPrimaryPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).maybePop();
          },
        );
        return;
      }

      // FIX: this used to be checked *inside* the `failed` branch below
      // via `txn.status == partial` — but a partial-status transaction is
      // returned as a repository *success* (Right(txn)), never routed to
      // the `failed` step by the provider, so that check was dead code.
      // `AirtimeToCashStep.partial` is now its own step, set directly by
      // the provider.
      if (next.step == AirtimeToCashStep.partial &&
          next.lastTransaction != null) {
        final txn = next.lastTransaction!;
        final failedAmount = txn.amountSold - txn.amountReceived;
        ResultStatusDialog.show(
          context,
          kind: ResultStatusKind.partial,
          title: 'Partially Successful',
          detailLines: [
            'Successfully converted: ₦${txn.amountReceived.toStringAsFixed(0)}',
            'Failed: ₦${failedAmount.toStringAsFixed(0)}',
          ],
          message:
              txn.failureReason ??
              'Some transactions could not be completed. Please contact '
                  'support if needed.',
          primaryLabel: 'Done',
          onPrimaryPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).maybePop();
          },
        );
        return;
      }

      if (next.step == AirtimeToCashStep.failed) {
        ResultStatusDialog.show(
          context,
          kind: ResultStatusKind.failure,
          title: 'Conversion Failed',
          message: next.submissionError ?? 'Please try again.',
          primaryLabel: 'Try Again',
          secondaryLabel: 'Close',
          onPrimaryPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            notifier.backToAmountEntry();
          },
          onSecondaryPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).maybePop();
          },
        );
      }
    });

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: context.height * 0.9),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Header(step: state.step),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: _buildBody(context, state, notifier),
              ),
            ),
            _Footer(
              state: state,
              notifier: notifier,
              onOtpVerify: () => notifier.verifyOtp(_otpValue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AirtimeToCashState state,
    AirtimeToCashNotifier notifier,
  ) {
    if (state.isLoadingNetworks) {
      return const Center(
        child: Padding(padding: EdgeInsets.all(24), child: AppLoader()),
      );
    }
    if (state.networksError != null) {
      return _ErrorRetry(
        message: state.networksError!,
        onRetry: notifier.fetchNetworks,
      );
    }

    switch (state.step) {
      case AirtimeToCashStep.networkSelection:
      case AirtimeToCashStep.phoneEntry:
      case AirtimeToCashStep.sendingOtp:
        return _NetworkAndPhoneSection(state: state, notifier: notifier);
      case AirtimeToCashStep.otpEntry:
      case AirtimeToCashStep.verifyingOtp:
        return _OtpSection(
          state: state,
          notifier: notifier,
          otpKey: _otpKey,
          onOtpChanged: (v) => setState(() => _otpValue = v),
          onResend: _handleResendOtp,
        );
      case AirtimeToCashStep.noActiveConfig:
        return _NoActiveConfigSection(notifier: notifier);
      case AirtimeToCashStep.balanceTooLow:
        return _BalanceTooLowSection(state: state, notifier: notifier);
      case AirtimeToCashStep.enteringAmount:
      case AirtimeToCashStep.checkingQuota:
      case AirtimeToCashStep.confirming:
      case AirtimeToCashStep.submitting:
      case AirtimeToCashStep.success:
      case AirtimeToCashStep.processing:
      case AirtimeToCashStep.partial:
      case AirtimeToCashStep.failed:
        return _AmountSection(state: state, notifier: notifier);
    }
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.step});

  final AirtimeToCashStep step;

  @override
  Widget build(BuildContext context) {
    final stage = _stageFor(step);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 12.w, 16.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.greyEE)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Airtime to Cash', style: context.textTheme.titleMedium),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    for (int i = 1; i <= 4; i++) ...[
                      Container(
                        width: 20.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: i <= stage
                              ? AppColors.primaryColor
                              : AppColors.greyEE,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      if (i != 4) SizedBox(width: 4.w),
                    ],
                    SizedBox(width: 8.w),
                    // Expanded(
                    //   child: Text(
                    //     'Step $stage of 4 • ${_stageLabels[stage - 1]}',
                    //     style: context.textTheme.labelMedium?.copyWith(
                    //       color: AppColors.grey80,
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.grey80,
                          ),
                          children: [
                            const TextSpan(text: 'Step '),
                            TextSpan(
                              text: '$stage',
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(text: ' of '),
                            const TextSpan(
                              text: '4',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(text: ' • '),
                            TextSpan(
                              text: _stageLabels[stage - 1],
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 32.w,
              height: 32.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.greyF5,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 16.sp, color: AppColors.grey33),
            ),
          ),
        ],
      ),
    );
  }
}

class _NetworkAndPhoneSection extends StatelessWidget {
  const _NetworkAndPhoneSection({required this.state, required this.notifier});

  final AirtimeToCashState state;
  final AirtimeToCashNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final showPhone = state.step != AirtimeToCashStep.networkSelection;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select your network', style: context.textTheme.titleSmall),
        SizedBox(height: 16.h),
        NetworkSelectorGrid(
          networks: state.networks,
          selectedNetwork: state.selectedNetwork,
          onSelected: notifier.selectNetwork,
        ),
        if (showPhone) ...[
          SizedBox(height: 24.h),
          Text('Phone number', style: context.textTheme.titleSmall),
          SizedBox(height: 4.h),
          Text(
            'Enter the number you will send the airtime from.',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey80,
            ),
          ),
          SizedBox(height: 12.h),
          AppTextField(
            controller: state.phoneController,
            hintText: '08012345678',
            keyboardType: TextInputType.phone,
            enabled:
                state.step == AirtimeToCashStep.phoneEntry ||
                state.step == AirtimeToCashStep.sendingOtp,
            validateFunction: (_) => state.phoneError,
          ),
          if (state.otpSendError != null) ...[
            SizedBox(height: 8.h),
            Text(
              state.otpSendError!,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.errorText,
              ),
            ),
          ],
          SizedBox(height: 26.h),
        ],
      ],
    );
  }
}

class _OtpSection extends StatelessWidget {
  const _OtpSection({
    required this.state,
    required this.notifier,
    required this.otpKey,
    required this.onOtpChanged,
    required this.onResend,
  });

  final AirtimeToCashState state;
  final AirtimeToCashNotifier notifier;
  final GlobalKey<OtpInputRowState> otpKey;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final maskedPhone = maskPhoneNumber(state.phoneController.text.trim());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Verify your phone number', style: context.textTheme.titleSmall),
        SizedBox(height: 6.h),
        Text(
          "We've sent a 6-digit verification code to $maskedPhone",
          style: context.textTheme.bodySmall?.copyWith(color: AppColors.grey80),
        ),
        SizedBox(height: 28.h),
        OtpInputRow(
          key: otpKey,
          enabled: state.step != AirtimeToCashStep.verifyingOtp,
          hasError: state.otpVerifyError != null,
          onChanged: onOtpChanged,
          onCompleted: notifier.verifyOtp,
        ),
        if (state.otpVerifyError != null) ...[
          SizedBox(height: 10.h),
          Center(
            child: Text(
              state.otpVerifyError!,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.errorText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        SizedBox(height: 24.h),
        Center(
          child: Column(
            children: [
              Text(
                "Didn't receive the code?",
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.grey33,
                ),
              ),
              SizedBox(height: 4.h),
              if (state.isResendingOtp)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 14.w,
                      height: 14.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.grey80,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text('Resending...', style: context.textTheme.bodySmall),
                  ],
                )
              else if (state.canResendOtp)
                TextButton(
                  onPressed: onResend,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Resend OTP',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14.sp,
                      color: AppColors.grey80,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Resend OTP in ${state.otpResendCountdown}s',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.grey80,
                      ),
                    ),
                  ],
                ),
              if (state.otpSendError != null && !state.isResendingOtp) ...[
                SizedBox(height: 8.h),
                Column(
                  children: [
                    Text(
                      state.otpSendError!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.errorText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: onResend,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _NoActiveConfigSection extends StatelessWidget {
  const _NoActiveConfigSection({required this.notifier});

  final AirtimeToCashNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: AppColors.warning,
          size: 40.sp,
        ),
        SizedBox(height: 12.h),
        Text(
          'No Active Airtime 2 Cash Config',
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'This network does not currently support Airtime-to-Cash conversion.',
          style: context.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),

        SizedBox(height: 12.h),
        TextButton(
          onPressed: notifier.backToNetworkSelection,
          child: const Text('Choose a different network'),
        ),
      ],
    );
  }
}

class _AmountSection extends StatelessWidget {
  const _AmountSection({required this.state, required this.notifier});

  final AirtimeToCashState state;
  final AirtimeToCashNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final network = state.selectedNetwork;
    if (network == null) return const SizedBox.shrink();

    final fieldsEnabled = state.step == AirtimeToCashStep.enteringAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "How much do you want to convert?".
        Text(
          'How much do you want to convert?',
          style: context.textTheme.titleSmall,
        ),
        SizedBox(height: 12.h),
        AppTextField(
          controller: state.amountController,
          hintText: '₦5,000',
          textStyle: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          inputFormatters: [CurrencyTextInputFormatter()],
          keyboardType: TextInputType.number,
          enabled: fieldsEnabled,
          onChange: notifier.onAmountChanged,
          validateFunction: (_) => state.amountError,
        ),
        SizedBox(height: 6.h),
        Text(
          'Min ₦${network.minAmount.toStringAsFixed(0)} • Max ₦${network.maxAmount.toStringAsFixed(0)} • '
          'Daily ₦${network.dailyLimit.toStringAsFixed(0)}',
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.grey80,
            fontSize: 10.sp,
          ),
        ),
        if (state.quotaError != null) ...[
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.error_outline,
                size: 14.sp,
                color: AppColors.errorText,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  state.quotaError!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.errorText,
                  ),
                ),
              ),
            ],
          ),
        ],
        if (state.step == AirtimeToCashStep.checkingQuota) ...[
          SizedBox(height: 10.h),
          Row(
            children: [
              const AppLoaderSpinnerKit(size: 14),
              SizedBox(width: 8.w),
              Text(
                'Checking availability...',
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ],
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("You'll receive", style: context.textTheme.bodySmall),
              SizedBox(height: 4.h),
              Text(
                '₦${state.amountToReceive.toStringAsFixed(0)}',
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              // Text(
              //   'Conversion rate: ${network.conversionRatePercent}%',
              //   style: context.textTheme.labelSmall?.copyWith(
              //     color: AppColors.grey80,
              //   ),
              // ),
              Text.rich(
                TextSpan(
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.grey80,
                  ),
                  children: [
                    TextSpan(text: 'Conversion rate: '),
                    TextSpan(
                      text: '${network.conversionRatePercent}%',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (state.tariffPlan != null) ...[
                      const TextSpan(text: ' • '),
                      TextSpan(
                        text: state.tariffPlan!,
                        style: const TextStyle(
                          color: AppColors.grey33,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 28.h),
        const Divider(color: AppColors.greyEE),
        SizedBox(height: 20.h),
        Row(
          children: [
            Text('Airtime Share PIN', style: context.textTheme.titleSmall),
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: () => AirtimeSharePinInfoDialog.show(context, [network]),
              child: Icon(
                Icons.info_outline,
                size: 16.sp,
                color: AppColors.info,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        AppTextField(
          controller: state.pinController,
          hintText: 'Enter your Airtime Share PIN',
          obscureText: true,
          keyboardType: TextInputType.number,
          enabled: fieldsEnabled,
          validateFunction: (_) => state.pinError,
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: notifier.goToManual,
          child: Text(
            'Forgot PIN? Call 300 to reset it.',
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.errorText,
              fontSize: 10.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.state,
    required this.notifier,
    required this.onOtpVerify,
  });

  final AirtimeToCashState state;
  final AirtimeToCashNotifier notifier;
  final VoidCallback onOtpVerify;

  VoidCallback? _primaryAction(BuildContext context) {
    switch (state.step) {
      case AirtimeToCashStep.networkSelection:
        return null;
      case AirtimeToCashStep.phoneEntry:
        return notifier.submitPhoneNumber;
      case AirtimeToCashStep.sendingOtp:
        return null;
      case AirtimeToCashStep.otpEntry:
        return onOtpVerify;
      case AirtimeToCashStep.verifyingOtp:
        return null;
      case AirtimeToCashStep.enteringAmount:
        return notifier.proceedToConfirm;
      case AirtimeToCashStep.checkingQuota:
      case AirtimeToCashStep.confirming:
      case AirtimeToCashStep.submitting:
        return null;
      case AirtimeToCashStep.noActiveConfig:
      case AirtimeToCashStep.success:
      case AirtimeToCashStep.processing:
      case AirtimeToCashStep.partial:
      case AirtimeToCashStep.failed:
        return null;
      default:
        return null;
    }
  }

  String _primaryLabel() {
    switch (state.step) {
      case AirtimeToCashStep.sendingOtp:
        return 'Sending OTP...';
      case AirtimeToCashStep.verifyingOtp:
        return 'Verifying...';
      case AirtimeToCashStep.checkingQuota:
        return 'Checking...';
      case AirtimeToCashStep.submitting:
        return 'Submitting...';
      case AirtimeToCashStep.otpEntry:
        return 'Verify Phone Number';
      default:
        return 'Continue';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (state.step == AirtimeToCashStep.noActiveConfig ||
        state.step == AirtimeToCashStep.balanceTooLow ||
        state.step == AirtimeToCashStep.success ||
        state.step == AirtimeToCashStep.processing ||
        state.step == AirtimeToCashStep.partial ||
        state.step == AirtimeToCashStep.failed) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.greyEE)),
      ),
      child: Row(
        children: [
          Expanded(
            child: BundlegramButton(
              text: 'Cancel',
              color: AppColors.greyEE,
              textStyle: const TextStyle(color: AppColors.black),
              onPressed: state.isBusy
                  ? null
                  : () => Navigator.of(context).maybePop(),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: BundlegramButton(
              text: _primaryLabel(),
              isLoading: state.isBusy,
              isEnabled: _primaryAction(context) != null && !state.isBusy,
              onPressed: _primaryAction(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline, color: AppColors.error, size: 32.sp),
        SizedBox(height: 8.h),
        Text(
          message,
          style: context.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        TextButton(onPressed: onRetry, child: const Text('Try Again')),
      ],
    );
  }
}

class _BalanceTooLowSection extends StatelessWidget {
  const _BalanceTooLowSection({required this.state, required this.notifier});

  final AirtimeToCashState state;
  final AirtimeToCashNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final network = state.selectedNetwork;
    return Column(
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: AppColors.warning,
          size: 40.sp,
        ),
        SizedBox(height: 12.h),
        Text(
          'Balance Too Low',
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'Your airtime balance (₦${state.airtimeBalance?.toStringAsFixed(2) ?? '0.00'}) '
          'is below the ₦${network?.minAmount.toStringAsFixed(0) ?? '-'} minimum for '
          '${network?.name ?? 'this network'}.',
          style: context.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        TextButton(
          onPressed: notifier.backToNetworkSelection,
          child: const Text('Choose a different network'),
        ),
      ],
    );
  }
}
