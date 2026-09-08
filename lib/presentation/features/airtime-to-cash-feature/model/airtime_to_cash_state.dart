import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:flutter/material.dart';

/// The discrete steps of the conversion flow.
enum AirtimeToCashStep {
  networkSelection,
  noActiveConfig,
  phoneEntry,
  sendingOtp,
  otpEntry,
  verifyingOtp,
  enteringAmount,
  checkingQuota,
  confirming,
  submitting,
  success,
  processing,
  partial,
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
    this.sessionId,
    this.amountError,
    this.quotaError,
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

  /// Returned by the real /verify endpoint; required by /transfer. There
  /// is no airtime-balance field — the real API doesn't expose one.
  final String? sessionId;

  final TextEditingController amountController;
  final String? amountError;

  /// Set when the real /check-quota call rejects the entered amount.
  final String? quotaError;

  final TextEditingController pinController;
  final String? pinError;

  final String? submissionError;
  final AirtimeToCashTransaction? lastTransaction;

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
      step == AirtimeToCashStep.checkingQuota ||
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
    Object? sessionId = _unset,
    Object? amountError = _unset,
    Object? quotaError = _unset,
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
      phoneError: phoneError == _unset
          ? this.phoneError
          : phoneError as String?,
      otpSendError: otpSendError == _unset
          ? this.otpSendError
          : otpSendError as String?,
      otpVerifyError: otpVerifyError == _unset
          ? this.otpVerifyError
          : otpVerifyError as String?,
      otpResendCountdown: otpResendCountdown ?? this.otpResendCountdown,
      canResendOtp: canResendOtp ?? this.canResendOtp,
      isResendingOtp: isResendingOtp ?? this.isResendingOtp,
      sessionId: sessionId == _unset ? this.sessionId : sessionId as String?,
      amountController: amountController,
      amountError: amountError == _unset
          ? this.amountError
          : amountError as String?,
      quotaError: quotaError == _unset
          ? this.quotaError
          : quotaError as String?,
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
