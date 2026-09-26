import 'dart:async';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/data/airtime_to_cash_failures.dart';
import 'package:bundlegram/data/airtime_to_cash_repository.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/data/repositories/airtime_to_cash_api_repo.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/model/airtime_to_cash_state.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_history_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:url_launcher/url_launcher.dart';

const int kOtpResendSeconds = 30;
const _networkDisplayOrder = ['MTN', 'AIRTEL', 'GLO', '9MOBILE'];

int _networkSortIndex(NetworkConfig n) {
  final idx = _networkDisplayOrder.indexOf(n.id);
  return idx == -1 ? _networkDisplayOrder.length : idx;
}

final airtimeToCashProvider =
    StateNotifierProvider.autoDispose<
      AirtimeToCashNotifier,
      AirtimeToCashState
    >(
      (ref) =>
          AirtimeToCashNotifier(ref, ref.read(airtimeToCashRepositoryProvider)),
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
      (fail) => state = state.copyWith(
        isLoadingNetworks: false,
        networksError: sanitizeErrorMessage(userFacingMessageFromFailure(fail)),
      ),
      (networks) {
        final sorted = [
          ...networks,
        ]..sort((a, b) => _networkSortIndex(a).compareTo(_networkSortIndex(b)));
        state = state.copyWith(isLoadingNetworks: false, networks: sorted);
      },
    );
  }

  void selectPresetAmount(int amount) {
    state.amountController.text = amount.toString();
    onAmountChanged(state.amountController.text);
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

  Future<void> goToManual() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '300');

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (e) {
      debugPrint('Unable to open phone dialer: $e');
    }
  }

  void backToNetworkSelection() {
    _countdownTimer?.cancel();
    state = state.copyWith(
      step: AirtimeToCashStep.networkSelection,
      selectedNetwork: null,
      phoneError: null,
      otpSendError: null,
      otpVerifyError: null,
      sessionId: null,
    );
  }

  String? _validatePhone(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 'Enter the phone number you are sending from';
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

    try {
      final result = await _repository.sendOtp(
        network: network,
        phoneNumber: state.phoneController.text.trim(),
      );

      result.fold(
        (Failure fail) {
          state = state.copyWith(
            step: AirtimeToCashStep.phoneEntry,
            otpSendError: sanitizeErrorMessage(
              userFacingMessageFromFailure(fail),
            ),
          );
        },
        (_) {
          state = state.copyWith(step: AirtimeToCashStep.otpEntry);
          _startResendCountdown();
        },
      );
    } catch (e, st) {
      debugPrint('submitPhoneNumber failed: $e\n$st');
      state = state.copyWith(
        step: AirtimeToCashStep.phoneEntry,
        otpSendError:
            'Something went wrong while sending the OTP. Please try again.',
      );
    }
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

  /// Dedicated resend entry point — distinct from [submitPhoneNumber] so
  /// the UI can show a "Resending..." state
  Future<void> resendOtp() async {
    final network = state.selectedNetwork;
    if (network == null || !state.canResendOtp || state.isResendingOtp) return;

    state = state.copyWith(isResendingOtp: true, otpSendError: null);
    try {
      final result = await _repository.sendOtp(
        network: network,
        phoneNumber: state.phoneController.text.trim(),
      );
      result.fold(
        (Failure fail) {
          state = state.copyWith(
            isResendingOtp: false,
            otpSendError: sanitizeErrorMessage(
              userFacingMessageFromFailure(fail),
            ),
          );
        },
        (_) {
          state = state.copyWith(isResendingOtp: false, otpVerifyError: null);
          _startResendCountdown();
        },
      );
    } catch (e, st) {
      debugPrint('resendOtp failed: $e\n$st');
      state = state.copyWith(
        isResendingOtp: false,
        otpSendError:
            'Something went wrong while resending the OTP. Please try again.',
      );
    }
  }

  Future<void> verifyOtp(String otp) async {
    final network = state.selectedNetwork;
    if (network == null) return;

    if (otp.trim().length < 4) {
      state = state.copyWith(
        otpVerifyError: 'Enter the code sent to your phone',
      );
      return;
    }

    state = state.copyWith(
      step: AirtimeToCashStep.verifyingOtp,
      otpVerifyError: null,
    );

    try {
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
        (verification) {
          _countdownTimer?.cancel();
          final balance = verification.airtimeBalance;

          if (balance != null && balance < network.minAmount) {
            state = state.copyWith(
              step: AirtimeToCashStep.balanceTooLow,
              sessionId: verification.sessionId,
              airtimeBalance: balance,
              tariffPlan: verification.tariff,
            );
            return;
          }

          state = state.copyWith(
            step: AirtimeToCashStep.enteringAmount,
            sessionId: verification.sessionId,
            airtimeBalance: balance,
            tariffPlan: verification.tariff,
          );

          if (balance != null) {
            final prefill = balance > network.maxAmount
                ? network.maxAmount
                : balance;
            state.amountController.text = prefill.toStringAsFixed(0);
            onAmountChanged(state.amountController.text);
          }
        },
      );
    } catch (e, st) {
      debugPrint('verifyOtp failed: $e\n$st');
      state = state.copyWith(
        step: AirtimeToCashStep.otpEntry,
        otpVerifyError:
            'Something went wrong verifying the code. Please try again.',
      );
    }
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

    final balance = state.airtimeBalance;
    if (balance != null && amount > balance) {
      return 'Amount exceeds your available airtime balance (₦${balance.toStringAsFixed(2)})';
    }
    if (amount < network.minAmount) {
      return 'Minimum amount is ₦${network.minAmount.toStringAsFixed(0)}';
    }
    if (amount > network.maxAmount) {
      return 'Maximum amount is ₦${network.maxAmount.toStringAsFixed(0)}';
    }
    return null;
  }

  String? _validatePin(String value) {
    if (value.trim().isEmpty) return 'Enter your Airtime Share PIN';
    if (value.trim().length != 4) return 'PIN must be 4 digits';
    return null;
  }

  void onAmountChanged(String _) {
    state = state.copyWith();
  }

  Future<void> proceedToConfirm() async {
    final network = state.selectedNetwork;
    if (network == null) return;

    final amountError = _validateAmount(state.amountController.text);
    final pinError = _validatePin(state.pinController.text);

    if (amountError != null || pinError != null) {
      state = state.copyWith(amountError: amountError, pinError: pinError);
      return;
    }

    final amount = double.tryParse(
      state.amountController.text.replaceAll(',', ''),
    );
    if (amount == null) return;

    state = state.copyWith(
      amountError: null,
      pinError: null,
      quotaError: null,
      step: AirtimeToCashStep.checkingQuota,
    );

    try {
      final quotaResult = await _repository.checkQuota(
        network: network,
        amount: amount,
      );

      quotaResult.fold(
        (Failure fail) {
          state = state.copyWith(
            step: AirtimeToCashStep.enteringAmount,
            quotaError: sanitizeErrorMessage(
              userFacingMessageFromFailure(fail),
            ),
          );
        },
        (_) {
          state = state.copyWith(step: AirtimeToCashStep.confirming);
        },
      );
    } catch (e, st) {
      debugPrint('proceedToConfirm failed: $e\n$st');
      state = state.copyWith(
        step: AirtimeToCashStep.enteringAmount,
        quotaError:
            'Something went wrong checking availability. Please try again.',
      );
    }
  }

  void backToAmountEntry() {
    state = state.copyWith(step: AirtimeToCashStep.enteringAmount);
  }

  AirtimeToCashStep _stepForTransaction(AirtimeToCashTransaction txn) {
    switch (txn.status) {
      case AirtimeToCashTxnStatus.processing:
        return AirtimeToCashStep.processing;
      case AirtimeToCashTxnStatus.partial:
        return AirtimeToCashStep.partial;
      case AirtimeToCashTxnStatus.success:
      case AirtimeToCashTxnStatus.failed:
      case AirtimeToCashTxnStatus.pending:
        return AirtimeToCashStep.success;
    }
  }

  Future<void> confirmAndSubmit() async {
    final network = state.selectedNetwork;
    final sessionId = state.sessionId;
    if (network == null || sessionId == null) return;

    final amount = double.tryParse(
      state.amountController.text.replaceAll(',', ''),
    );
    if (amount == null) return;

    state = state.copyWith(
      step: AirtimeToCashStep.submitting,
      submissionError: null,
    );

    try {
      final result = await _repository.convert(
        network: network,
        phoneNumber: state.phoneController.text.trim(),
        amount: amount,
        airtimeSharePin: state.pinController.text.trim(),
        sessionId: sessionId,
      );

      result.fold(
        (Failure fail) {
          state = state.copyWith(
            step: AirtimeToCashStep.failed,
            submissionError: sanitizeErrorMessage(
              userFacingMessageFromFailure(fail),
            ),
          );
        },
        (txn) {
          state = state.copyWith(
            step: _stepForTransaction(txn),
            lastTransaction: txn,
          );
          unawaited(_ref.read(airtimeToCashHistoryProvider.notifier).refresh());
        },
      );
    } catch (e, st) {
      debugPrint('confirmAndSubmit failed: $e\n$st');
      state = state.copyWith(
        step: AirtimeToCashStep.failed,
        submissionError:
            'Something went wrong while submitting. Please try again.',
      );
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    state.disposeControllers();
    super.dispose();
  }
}
