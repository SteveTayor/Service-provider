import 'package:bundlegram/data/models/airtime_2_cash/airtime_balance.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:flutter/material.dart';

/// The discrete steps of the conversion flow. Kept as a single cohesive
/// enum (rather than scattered `isLoading`/`isSending`/`isVerifying`
/// booleans) so the UI can switch on one source of truth.
enum AirtimeToCashStep {
  networkSelection,
  noActiveConfig,
  phoneEntry,
  sendingOtp,
  otpEntry,
  verifyingOtp,
  enteringAmount,
  confirming,
  submitting,
  success,
  partialSuccess,
  failed,
}

/// A sentinel used to distinguish "leave field unchanged" from
/// "explicitly set this nullable field to null" in [AirtimeToCashState.copyWith].
class _Unset {
  const _Unset();
}

const _unset = _Unset();

class AirtimeToCashState {
  AirtimeToCashState({
    required this.step,
    required this.networks,
    required this.phoneController,
    required this.amountController,
    required this.pinController,
    this.selectedNetwork,
    this.isLoadingNetworks = false,
    this.networksError,
    this.phoneError,
    this.otpSendError,
    this.otpVerifyError,
    this.otpResendCountdown = 0,
    this.canResendOtp = false,
    this.isResendingOtp = false,
    this.airtimeBalance,
    this.isLoadingBalance = false,
    this.amountError,
    this.pinError,
    this.submissionError,
    this.lastTransaction,
  });

  factory AirtimeToCashState.initial() => AirtimeToCashState(
        step: AirtimeToCashStep.networkSelection,
        networks: const [],
        phoneController: TextEditingController(),
        amountController: TextEditingController(),
        pinController: TextEditingController(),
      );

  final AirtimeToCashStep step;
  final List<NetworkConfig> networks;
  final NetworkConfig? selectedNetwork;
  final bool isLoadingNetworks;
  final String? networksError;

  final TextEditingController phoneController;
  final String? phoneError;

  final String? otpSendError;
  final String? otpVerifyError;
  final int otpResendCountdown;
  final bool canResendOtp;
  final bool isResendingOtp;

  final AirtimeBalance? airtimeBalance;
  final bool isLoadingBalance;

  final TextEditingController amountController;
  final String? amountError;

  final TextEditingController pinController;
  final String? pinError;

  final String? submissionError;
  final AirtimeToCashTransaction? lastTransaction;

  /// Amount to receive, computed live from [amountController] and the
  /// selected network's conversion rate. Zero when the amount is invalid
  /// or no network is selected.
  double get amountToReceive {
    final network = selectedNetwork;
    if (network == null) return 0;
    final amount = double.tryParse(amountController.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) return 0;
    return amount * network.conversionRatePercent / 100;
  }

  bool get isBusy =>
      step == AirtimeToCashStep.sendingOtp ||
      step == AirtimeToCashStep.verifyingOtp ||
      step == AirtimeToCashStep.submitting ||
      isResendingOtp;

  AirtimeToCashState copyWith({
    AirtimeToCashStep? step,
    List<NetworkConfig>? networks,
    Object? selectedNetwork = _unset,
    bool? isLoadingNetworks,
    Object? networksError = _unset,
    Object? phoneError = _unset,
    Object? otpSendError = _unset,
    Object? otpVerifyError = _unset,
    int? otpResendCountdown,
    bool? canResendOtp,
    bool? isResendingOtp,
    Object? airtimeBalance = _unset,
    bool? isLoadingBalance,
    Object? amountError = _unset,
    Object? pinError = _unset,
    Object? submissionError = _unset,
    Object? lastTransaction = _unset,
  }) {
    return AirtimeToCashState(
      step: step ?? this.step,
      networks: networks ?? this.networks,
      selectedNetwork: selectedNetwork == _unset
          ? this.selectedNetwork
          : selectedNetwork as NetworkConfig?,
      isLoadingNetworks: isLoadingNetworks ?? this.isLoadingNetworks,
      networksError: networksError == _unset
          ? this.networksError
          : networksError as String?,
      phoneController: phoneController,
      phoneError:
          phoneError == _unset ? this.phoneError : phoneError as String?,
      otpSendError:
          otpSendError == _unset ? this.otpSendError : otpSendError as String?,
      otpVerifyError: otpVerifyError == _unset
          ? this.otpVerifyError
          : otpVerifyError as String?,
      otpResendCountdown: otpResendCountdown ?? this.otpResendCountdown,
      canResendOtp: canResendOtp ?? this.canResendOtp,
      isResendingOtp: isResendingOtp ?? this.isResendingOtp,
      airtimeBalance: airtimeBalance == _unset
          ? this.airtimeBalance
          : airtimeBalance as AirtimeBalance?,
      isLoadingBalance: isLoadingBalance ?? this.isLoadingBalance,
      amountController: amountController,
      amountError:
          amountError == _unset ? this.amountError : amountError as String?,
      pinController: pinController,
      pinError: pinError == _unset ? this.pinError : pinError as String?,
      submissionError: submissionError == _unset
          ? this.submissionError
          : submissionError as String?,
      lastTransaction: lastTransaction == _unset
          ? this.lastTransaction
          : lastTransaction as AirtimeToCashTransaction?,
    );
  }

  void disposeControllers() {
    phoneController.dispose();
    amountController.dispose();
    pinController.dispose();
  }
}
