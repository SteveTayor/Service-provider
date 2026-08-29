import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
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

/// Opens the Airtime-to-Cash conversion flow as a bottom sheet, following
/// the app's existing `showBottomSheet` pattern for multi-step flows.
Future<void> showAirtimeToCashConversionSheet(BuildContext context) {
  // airtimeToCashProvider is `.autoDispose`, so it initializes fresh when
  // this sheet is first built and tears itself down (cancelling timers,
  // disposing controllers) once the sheet closes and nothing watches it
  // anymore — no nested ProviderScope needed, which would otherwise
  // isolate this flow from airtimeToCashHistoryProvider on the dashboard.
  return context.showBottomSheet(
    isDismissible: true,
    showDragHandle: true,
    child: const ConversionFlowSheet(),
  );
}

class ConversionFlowSheet extends ConsumerStatefulWidget {
  const ConversionFlowSheet({super.key});

  @override
  ConsumerState<ConversionFlowSheet> createState() =>
      _ConversionFlowSheetState();
}

class _ConversionFlowSheetState extends ConsumerState<ConversionFlowSheet> {
  final _otpKey = GlobalKey<OtpInputRowState>();
  String _otpValue = '';

  Future<void> _handleConfirmingStep(NetworkConfig network) async {
    final state = ref.read(airtimeToCashProvider);
    final amount = double.tryParse(
          state.amountController.text.replaceAll(',', ''),
        ) ??
        0;

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
    final r = context.responsive;
    final state = ref.watch(airtimeToCashProvider);
    final notifier = ref.read(airtimeToCashProvider.notifier);

    ref.listen<AirtimeToCashState>(airtimeToCashProvider, (previous, next) {
      if (previous?.step != next.step) {
        if (next.step == AirtimeToCashStep.confirming &&
            next.selectedNetwork != null) {
          _handleConfirmingStep(next.selectedNetwork!);
        }
        if (next.step == AirtimeToCashStep.success &&
            next.lastTransaction != null) {
          final txn = next.lastTransaction!;
          ResultStatusDialog.show(
            context,
            kind: ResultStatusKind.success,
            title: 'Success',
            message:
                'You received ₦${txn.amountReceived.toStringAsFixed(0)} for '
                '₦${txn.amountSold.toStringAsFixed(0)} of ${txn.networkName} airtime.',
            onPrimaryPressed: () {
              // showPopUp uses the root navigator; the bottom sheet uses
              // the local one — close each explicitly rather than relying
              // on a shared stack.
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).maybePop();
            },
          );
        }
        if (next.step == AirtimeToCashStep.partialSuccess &&
            next.lastTransaction != null) {
          final txn = next.lastTransaction!;
          final failedAmount = txn.amountSold - txn.amountReceived;
          ResultStatusDialog.show(
            context,
            kind: ResultStatusKind.partial,
            title: 'Partial Success',
            detailLines: [
              'Successfully converted: ₦${txn.amountReceived.toStringAsFixed(0)}',
              'Failed: ₦${failedAmount.toStringAsFixed(0)}',
            ],
            message: txn.failureReason ??
                'Some transactions could not be completed. Please contact support if needed.',
            onPrimaryPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).maybePop();
            },
          );
        }
        if (next.step == AirtimeToCashStep.failed) {
          ResultStatusDialog.show(
            context,
            kind: ResultStatusKind.failure,
            title: 'Conversion Failed',
            message: next.submissionError ?? 'Please try again.',
            primaryLabel: 'Try Again',
            onPrimaryPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              notifier.backToAmountEntry();
            },
          );
        }
      }
    });

    return Container(
      constraints: BoxConstraints(maxHeight: context.height * 0.9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(step: state.step),
          Flexible(
            child: SingleChildScrollView(
              padding: r.padding(all: 20),
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
    );
  }

  Widget _buildBody(
    BuildContext context,
    AirtimeToCashState state,
    AirtimeToCashNotifier notifier,
  ) {
    if (state.isLoadingNetworks) {
      return const Center(
          child: Padding(padding: EdgeInsets.all(24), child: AppLoader()));
    }
    if (state.networksError != null) {
      return _ErrorRetry(
          message: state.networksError!, onRetry: notifier.fetchNetworks);
    }

    switch (state.step) {
      case AirtimeToCashStep.networkSelection:
      case AirtimeToCashStep.phoneEntry:
      case AirtimeToCashStep.sendingOtp:
      case AirtimeToCashStep.otpEntry:
      case AirtimeToCashStep.verifyingOtp:
        return _NetworkAndPhoneSection(
          state: state,
          notifier: notifier,
          otpKey: _otpKey,
          onOtpChanged: (v) => setState(() => _otpValue = v),
        );
      case AirtimeToCashStep.noActiveConfig:
        return _NoActiveConfigSection(notifier: notifier);
      case AirtimeToCashStep.enteringAmount:
      case AirtimeToCashStep.confirming:
      case AirtimeToCashStep.submitting:
      case AirtimeToCashStep.success:
      case AirtimeToCashStep.partialSuccess:
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
    final r = context.responsive;
    return Container(
      width: double.infinity,
      padding: r.padding(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.success, AppColors.success.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Airtime To Cash',
                style: context.textTheme.titleMedium
                    ?.copyWith(color: Colors.white),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Instant',
                  style: context.textTheme.labelSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NetworkAndPhoneSection extends StatelessWidget {
  const _NetworkAndPhoneSection({
    required this.state,
    required this.notifier,
    required this.otpKey,
    required this.onOtpChanged,
  });

  final AirtimeToCashState state;
  final AirtimeToCashNotifier notifier;
  final GlobalKey<OtpInputRowState> otpKey;
  final ValueChanged<String> onOtpChanged;

  @override
  Widget build(BuildContext context) {
    final showPhone = state.step != AirtimeToCashStep.networkSelection;
    final showOtp = state.step == AirtimeToCashStep.otpEntry ||
        state.step == AirtimeToCashStep.verifyingOtp;
    final isCheckingAvailability = state.step == AirtimeToCashStep.phoneEntry &&
        state.selectedNetwork != null &&
        false; // reserved: flip true while an async availability check runs

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Network', style: context.textTheme.bodyMedium),
        SizedBox(height: 12.h),
        NetworkSelectorGrid(
          networks: state.networks,
          selectedNetwork: state.selectedNetwork,
          onSelected: notifier.selectNetwork,
        ),
        // if (isCheckingAvailability) ...[
        //   SizedBox(height: 12.h),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       const AppLoaderSpinnerKit(size: 16),
        //       SizedBox(width: 8.w),
        //       Text('Checking availability...',
        //           style: context.textTheme.bodySmall),
        //     ],
        //   ),
        // ],
        if (showPhone) ...[
          SizedBox(height: 20.h),
          Text('Enter phone number you are sending from',
              style: context.textTheme.bodyMedium),
          SizedBox(height: 8.h),
          AppTextField(
            controller: state.phoneController,
            hintText: 'Eg: 08012345678',
            keyboardType: TextInputType.phone,
            enabled: state.step == AirtimeToCashStep.phoneEntry ||
                state.step == AirtimeToCashStep.sendingOtp,
            validateFunction: (_) => state.phoneError,
          ),
          if (state.otpSendError != null) ...[
            SizedBox(height: 6.h),
            Text(
              state.otpSendError!,
              style: context.textTheme.bodySmall
                  ?.copyWith(color: AppColors.errorText),
            ),
          ],
        ],
        if (showOtp) ...[
          SizedBox(height: 20.h),
          Text('Enter OTP',
              style: context.textTheme.bodyMedium, textAlign: TextAlign.center),
          SizedBox(height: 6.h),
          Text(
            'A six-digit OTP has been sent to ${state.phoneController.text.trim()}',
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          OtpInputRow(
            key: otpKey,
            enabled: state.step != AirtimeToCashStep.verifyingOtp,
            hasError: state.otpVerifyError != null,
            onChanged: onOtpChanged,
            onCompleted: notifier.verifyOtp,
          ),
          if (state.otpVerifyError != null) ...[
            SizedBox(height: 8.h),
            Text(
              state.otpVerifyError!,
              style: context.textTheme.bodySmall
                  ?.copyWith(color: AppColors.errorText),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 12.h),
          Center(
            child: state.canResendOtp
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle,
                          color: AppColors.success, size: 16.sp),
                      SizedBox(width: 6.w),
                      Text('You can now resend OTP',
                          style: context.textTheme.bodySmall),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time,
                          color: AppColors.grey80, size: 16.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'Resend OTP in ${state.otpResendCountdown} seconds',
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
          ),
        ],
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
        Icon(Icons.warning_amber_rounded,
            color: AppColors.warning, size: 40.sp),
        SizedBox(height: 12.h),
        Text(
          'No Active Airtime 2 Cash Config',
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'This network does not currently support instant Airtime-to-Cash conversion.',
          style: context.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        BundlegramButton(
          text: 'Go to Manual',
          width: double.infinity,
          buttonStyle: null,
          isOutline: true,
          onPressed: notifier.goToManual,
        ),
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
    final balance = state.airtimeBalance;
    if (network == null || balance == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Airtime Balance', style: context.textTheme.bodyMedium),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₦${balance.amount.toStringAsFixed(2)}',
                    style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.success, fontWeight: FontWeight.w700),
                  ),
                  Text(balance.networkLabel,
                      style: context.textTheme.bodySmall),
                ],
              ),
              Icon(Icons.refresh, color: AppColors.success),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Text('Enter Airtime to Sell', style: context.textTheme.bodyMedium),
        SizedBox(height: 8.h),
        AppTextField(
          controller: state.amountController,
          hintText: 'E.g 100',
          keyboardType: TextInputType.number,
          enabled: state.step == AirtimeToCashStep.enteringAmount,
          onChange: notifier.onAmountChanged,
          validateFunction: (_) => state.amountError,
        ),
        SizedBox(height: 4.h),
        Text(
          'Min: ₦${network.minAmount.toStringAsFixed(0)} | Max: '
          '₦${network.maxAmount.toStringAsFixed(0)} | Daily: ₦${network.dailyLimit.toStringAsFixed(0)}',
          style:
              context.textTheme.labelSmall?.copyWith(color: AppColors.grey80),
        ),
        SizedBox(height: 16.h),
        Text('Amount to Receive (₦)', style: context.textTheme.bodyMedium),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₦${state.amountToReceive.toStringAsFixed(0)}',
                style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.success, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Text('Conversion rate: ${network.conversionRatePercent}% ',
                      style: context.textTheme.labelSmall),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      network.name,
                      style: context.textTheme.labelSmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text('Airtime Share PIN', style: context.textTheme.bodyMedium),
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: () => AirtimeSharePinInfoDialog.show(context, [network]),
              child:
                  Icon(Icons.info_outline, size: 16.sp, color: AppColors.info),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        AppTextField(
          controller: state.pinController,
          hintText: 'E.g 9076',
          obscureText: true,
          keyboardType: TextInputType.number,
          enabled: state.step == AirtimeToCashStep.enteringAmount,
          validateFunction: (_) => state.pinError,
        ),
        SizedBox(height: 4.h),
        GestureDetector(
          onTap: notifier.goToManual,
          child: Row(
            children: [
              Icon(Icons.error_outline,
                  size: 12.sp, color: AppColors.errorText),
              SizedBox(width: 4.w),
              Text(
                'Forgot PIN? Call 300 to reset it.',
                style: context.textTheme.labelSmall
                    ?.copyWith(color: AppColors.errorText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer(
      {required this.state, required this.notifier, required this.onOtpVerify});

  final AirtimeToCashState state;
  final AirtimeToCashNotifier notifier;
  final VoidCallback onOtpVerify;

  VoidCallback? _primaryAction(BuildContext context) {
    switch (state.step) {
      case AirtimeToCashStep.networkSelection:
        return state.selectedNetwork == null ? null : () {};
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
      case AirtimeToCashStep.confirming:
      case AirtimeToCashStep.submitting:
        return null;
      case AirtimeToCashStep.noActiveConfig:
      case AirtimeToCashStep.success:
      case AirtimeToCashStep.partialSuccess:
      case AirtimeToCashStep.failed:
        return null;
    }
  }

  String _primaryLabel() {
    switch (state.step) {
      case AirtimeToCashStep.sendingOtp:
        return 'Sending OTP...';
      case AirtimeToCashStep.verifyingOtp:
        return 'Verifying...';
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
        state.step == AirtimeToCashStep.success ||
        state.step == AirtimeToCashStep.partialSuccess ||
        state.step == AirtimeToCashStep.failed) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
      child: Row(
        children: [
          Expanded(
            child: BundlegramButton(
              text: 'Cancel',
              color: AppColors.greyEE,
              textStyle: TextStyle(color: AppColors.black),
              onPressed:
                  state.isBusy ? null : () => Navigator.of(context).maybePop(),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
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
        Text(message,
            style: context.textTheme.bodySmall, textAlign: TextAlign.center),
        SizedBox(height: 12.h),
        TextButton(onPressed: onRetry, child: const Text('Try Again')),
      ],
    );
  }
}
