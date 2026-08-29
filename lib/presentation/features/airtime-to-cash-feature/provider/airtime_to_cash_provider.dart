import 'dart:async';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/data/airtime_to_cash_failures.dart';
import 'package:bundlegram/data/airtime_to_cash_repository.dart';
import 'package:bundlegram/data/mock_airtime_to_cash_repository.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/model/airtime_to_cash_state.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_history_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

const int kOtpResendSeconds = 30;

/// One provider instance backs one open conversion flow/sheet. The screen
/// should create it inside the modal's widget tree (e.g. via a
/// `ProviderScope(overrides: ...)` or simply by reading it fresh each time
/// the sheet opens) so state resets naturally when the sheet is dismissed.
final airtimeToCashProvider = StateNotifierProvider.autoDispose<
    AirtimeToCashNotifier, AirtimeToCashState>(
  (ref) => AirtimeToCashNotifier(
    ref,
    ref.read(airtimeToCashRepositoryProvider),
  ),
);

class AirtimeToCashNotifier extends StateNotifier<AirtimeToCashState> {
  AirtimeToCashNotifier(this._ref, this._repository)
      : super(AirtimeToCashState.initial()) {
    fetchNetworks();
  }

  final Ref _ref;
  final IAirtimeToCashRepository _repository;
  Timer? _countdownTimer;

  Future<void> fetchNetworks() async {
    state = state.copyWith(isLoadingNetworks: true, networksError: null);
    final result = await _repository.getNetworks();
    result.fold(
      (Failure fail) => state = state.copyWith(
        isLoadingNetworks: false,
        networksError: sanitizeErrorMessage(userFacingMessageFromFailure(fail)),
      ),
      (networks) => state = state.copyWith(
        isLoadingNetworks: false,
        networks: [],
      ),
    );
  }

  void selectNetwork(NetworkConfig network) {
    if (!network.isAvailable) return;

    state = state.copyWith(
      selectedNetwork: network,
      phoneError: null,
      otpSendError: null,
    );

    if (!network.hasActiveConfig || !network.supportsInstantConversion) {
      state = state.copyWith(step: AirtimeToCashStep.noActiveConfig);
      return;
    }

    state = state.copyWith(step: AirtimeToCashStep.phoneEntry);
  }

  /// Extensible hook for a future manual-conversion flow. Kept separate
  /// from the instant flow per the feature spec.
  void goToManual() {
    // For the manual conversion flow.
  }

  void backToNetworkSelection() {
    _countdownTimer?.cancel();
    state = state.copyWith(
      step: AirtimeToCashStep.networkSelection,
      selectedNetwork: null,
      phoneError: null,
      otpSendError: null,
      otpVerifyError: null,
      airtimeBalance: null,
    );
  }

  String? _validatePhone(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 'Enter the phone number you are sending from';
    // Nigerian local-format mobile number: 11 digits starting with 0.
    // NOTE: replace with the app's existing phone-validation utility if one
    // is already defined elsewhere in the codebase, to avoid duplicating it.
    final isValid = RegExp(r'^0[789][01]\d{8}$').hasMatch(trimmed);
    if (!isValid) return 'Enter a valid Nigerian phone number';
    return null;
  }

  Future<void> submitPhoneNumber() async {
    final network = state.selectedNetwork;
    if (network == null) return;

    final error = _validatePhone(state.phoneController.text);
    if (error != null) {
      state = state.copyWith(phoneError: error);
      return;
    }

    state = state.copyWith(
      phoneError: null,
      otpSendError: null,
      step: AirtimeToCashStep.sendingOtp,
    );

    final result = await _repository.sendOtp(
      network: network,
      phoneNumber: state.phoneController.text.trim(),
    );

    result.fold(
      (Failure fail) {
        state = state.copyWith(
          step: AirtimeToCashStep.phoneEntry,
          otpSendError:
              sanitizeErrorMessage(userFacingMessageFromFailure(fail)),
        );
      },
      (_) {
        state = state.copyWith(step: AirtimeToCashStep.otpEntry);
        _startResendCountdown();
      },
    );
  }

  void _startResendCountdown() {
    _countdownTimer?.cancel();
    state = state.copyWith(
      otpResendCountdown: kOtpResendSeconds,
      canResendOtp: false,
    );
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      final remaining = state.otpResendCountdown - 1;
      if (remaining <= 0) {
        timer.cancel();
        state = state.copyWith(otpResendCountdown: 0, canResendOtp: true);
      } else {
        state = state.copyWith(otpResendCountdown: remaining);
      }
    });
  }

  Future<void> resendOtp() async {
    final network = state.selectedNetwork;
    if (network == null || !state.canResendOtp || state.isResendingOtp) return;

    state = state.copyWith(isResendingOtp: true, otpSendError: null);
    final result = await _repository.sendOtp(
      network: network,
      phoneNumber: state.phoneController.text.trim(),
    );
    result.fold(
      (Failure fail) {
        state = state.copyWith(
          isResendingOtp: false,
          otpSendError:
              sanitizeErrorMessage(userFacingMessageFromFailure(fail)),
        );
      },
      (_) {
        state = state.copyWith(isResendingOtp: false);
        _startResendCountdown();
      },
    );
  }

  Future<void> verifyOtp(String otp) async {
    final network = state.selectedNetwork;
    if (network == null) return;

    if (otp.length != 6) {
      state = state.copyWith(otpVerifyError: 'Enter the 6-digit code');
      return;
    }

    state = state.copyWith(
      step: AirtimeToCashStep.verifyingOtp,
      otpVerifyError: null,
    );

    final result = await _repository.verifyOtp(
      network: network,
      phoneNumber: state.phoneController.text.trim(),
      otp: otp,
    );

    result.fold(
      (Failure fail) {
        final message = _messageForOtpFailure(fail);
        state = state.copyWith(
          step: AirtimeToCashStep.otpEntry,
          otpVerifyError: message,
        );
      },
      (balance) {
        _countdownTimer?.cancel();
        state = state.copyWith(
          step: AirtimeToCashStep.enteringAmount,
          airtimeBalance: balance,
        );
      },
    );
  }

  String _messageForOtpFailure(Failure fail) {
    if (fail is ExpiredOtpFailure) {
      return 'This OTP has expired. Please resend and try again.';
    }
    if (fail is InvalidOtpFailure) {
      return 'Incorrect OTP. Please check and try again.';
    }
    return sanitizeErrorMessage(userFacingMessageFromFailure(fail));
  }

  String? _validateAmount(String value) {
    final network = state.selectedNetwork;
    if (network == null) return 'Select a network first';
    final amount = double.tryParse(value.replaceAll(',', ''));
    if (amount == null || amount <= 0)
      return 'Enter the amount of airtime to sell';
    if (amount < network.minAmount) {
      return 'Minimum amount is ₦${network.minAmount.toStringAsFixed(0)}';
    }
    if (amount > network.maxAmount) {
      return 'Maximum amount is ₦${network.maxAmount.toStringAsFixed(0)}';
    }
    final balance = state.airtimeBalance?.amount ?? 0;
    if (amount > balance) return 'Amount exceeds your airtime balance';
    return null;
  }

  String? _validatePin(String value) {
    if (value.trim().isEmpty) return 'Enter your Airtime Share PIN';
    if (value.trim().length != 4) return 'PIN must be 4 digits';
    return null;
  }

  void onAmountChanged(String _) {
    // amountToReceive is a computed getter on the state, so just trigger a
    // rebuild by re-emitting the same reference with an incremented step.
    state = state.copyWith();
  }

  /// Validates amount + PIN and, if valid, moves to the confirmation step.
  void proceedToConfirm() {
    final amountError = _validateAmount(state.amountController.text);
    final pinError = _validatePin(state.pinController.text);

    if (amountError != null || pinError != null) {
      state = state.copyWith(amountError: amountError, pinError: pinError);
      return;
    }

    state = state.copyWith(
      amountError: null,
      pinError: null,
      step: AirtimeToCashStep.confirming,
    );
  }

  void backToAmountEntry() {
    state = state.copyWith(step: AirtimeToCashStep.enteringAmount);
  }

  Future<void> confirmAndSubmit() async {
    final network = state.selectedNetwork;
    if (network == null) return;

    final amount = double.tryParse(
      state.amountController.text.replaceAll(',', ''),
    );
    if (amount == null) return;

    state = state.copyWith(
      step: AirtimeToCashStep.submitting,
      submissionError: null,
    );

    final result = await _repository.convert(
      network: network,
      phoneNumber: state.phoneController.text.trim(),
      amount: amount,
      airtimeSharePin: state.pinController.text.trim(),
    );

    result.fold(
      (Failure fail) {
        state = state.copyWith(
          step: AirtimeToCashStep.failed,
          submissionError:
              sanitizeErrorMessage(userFacingMessageFromFailure(fail)),
        );
      },
      (txn) {
        final transaction = txn as AirtimeToCashTransaction?;
        final nextStep = transaction?.status == AirtimeToCashTxnStatus.partial
            ? AirtimeToCashStep.partialSuccess
            : AirtimeToCashStep.success;
        state = state.copyWith(step: nextStep, lastTransaction: transaction);
        // Refresh the dashboard's transaction list in the background.
        unawaited(_ref.read(airtimeToCashHistoryProvider.notifier).refresh());
      },
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    state.disposeControllers();
    super.dispose();
  }
}
