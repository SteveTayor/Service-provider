import 'dart:async';

import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:go_router/go_router.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';

final pinControllerProvider =
    ChangeNotifierProvider.autoDispose<PinController>((ref) {
  return PinController(
    ref,
    ref.read(apiServiceProvider),
    ref.read(secureStorageHelperProvider),
  );
});

class PinController extends ChangeNotifier {
  PinController(this._ref, this._api, this._storage);

  final Ref _ref;
  final ApiService _api;
  final SecureStorageHelper _storage;

  List<String> pin = ['', '', '', ''];
  int index = 0;
  String? errorMessage;
  String? initialPin;
  PinScreenMode mode = PinScreenMode.create;
  VoidCallback? onCompleted;
  bool isButtonDisabled = false;

  AnimationController? shakeController;

  // Password form
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;

  void setShake(AnimationController controller) {
    shakeController = controller;
  }

  void start(
    PinScreenMode m, {
    String? initialPin,
    VoidCallback? onComplete,
  }) {
    mode = m;
    this.initialPin = initialPin;
    onCompleted = onComplete;
    reset();
  }

  void reset() {
    pin = ['', '', '', ''];
    index = 0;
    errorMessage = null;
    notifyListeners();
  }

  void updatePin(String val, BuildContext context) {
    if (index < 4) {
      pin[index] = val;
      index++;
      notifyListeners();
    }

    if (index == 4) checkPin(context);
  }

  void deletePin() {
    if (index > 0) {
      index--;
      pin[index] = '';
      errorMessage = null;
      notifyListeners();
    }
  }

  void showError(String message) {
    shakeController?.forward(from: 0);
    errorMessage = message;
    reset();
  }

  Future<void> checkPin(BuildContext context) async {
    final entered = pin.join();

    switch (mode) {
      case PinScreenMode.create:
        initialPin = entered;
        mode = PinScreenMode.confirm;
        reset();
        unawaited(context.push(RouteConstants.pinScreen));
        if (onCompleted != null) {
          onCompleted!.call();
        } else {
          unawaited(context.push(RouteConstants.pinScreen));
        }
        break;

      case PinScreenMode.confirm:
        if (entered == initialPin) {
          await _createPinOnServer(context, entered);
        } else {
          showError("PIN does not match. Try again.");
        }
        break;

      // ✅ Removed validate stage completely
    }
  }

  Future<void> _createPinOnServer(BuildContext context, String pin) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      context.showErrorSnackBar("Token missing. Please log in again.");
      return;
    }

    final res = await _api.createPin(token, pin, pin);
    res.fold((failure) {
      context.showErrorSnackBar(
        failure.properties.isNotEmpty
            ? failure.properties.join('\n')
            : "Failed to create PIN",
      );
    }, (data) async {
      if (data.status == "success") {
        final userEmail = await _storage.getRememberedEmail();
        if (userEmail != null) {
          await _storage.setPin(userEmail, pin);
        }
        unawaited(Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const TransactionSuccessful(
              title: 'Account pin created!',
              subTitle:
                  'You can now use your account PIN when performing transactions.',
              isBasicInfo: true,
            ),
          ),
        ));
      }
    });
  }

  Future<bool> resetPinWithPassword(
      String password, BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      context.showErrorSnackBar("Token missing. Please log in again.");
      return false;
    }

    final res = await _api.resetPin(token, password);
    return res.fold(
      (failure) {
        context.showErrorSnackBar(
          failure.properties.isNotEmpty
              ? failure.properties.join('\n')
              : "Failed to reset PIN",
        );
        return false;
      },
      (_) async {
        final userEmail = await _storage.getRememberedEmail();
        if (userEmail != null) {
          await _storage.clearPin(userEmail);
        }
        return true;
      },
    );
  }

  // Password validation utilities
  String? validatePassword(String? input) {
    if (input == null || input.trim().isEmpty) return 'Password required';
    return null;
  }

  Future<String?> validatePasswordAsync() async {
    isButtonDisabled = true;
    notifyListeners();
    try {
      final input = passwordController.text.trim();
      final storedPassword = await _storage.getPassword();
      if (storedPassword == null || storedPassword != input) {
        return 'Incorrect password';
      }
      return null;
    } finally {
      isButtonDisabled = false; // Always re-enable the button
      notifyListeners();
    }
  }

  void validateForm() {
    isFormValid = passwordController.text.trim().isNotEmpty;
    notifyListeners();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
