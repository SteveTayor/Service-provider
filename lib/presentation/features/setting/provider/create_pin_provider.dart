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
    BuildContext? context,
    bool navigateToSuccess = false,
  }) {
    mode = m;
    this.initialPin = initialPin;
    onCompleted = () {
      if (navigateToSuccess && context != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => const TransactionSuccessful(
              title: 'Account pin changed!',
              subTitle: 'You can now use your new PIN.',
            ),
          ),
        );
      } else {
        onComplete?.call();
      }
    };
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

        break;

      case PinScreenMode.confirm:
        if (entered == initialPin) {
          mode = PinScreenMode.validate;
          reset();
          unawaited(context.push(RouteConstants.pinScreen));
        } else {
          showError("PIN does not match. Try again.");
        }
        break;

      case PinScreenMode.validate:
        if (entered == initialPin) {
          await _createPinOnServer(context, entered);
        } else {
          showError("Incorrect PIN.");
        }
        break;
    }
  }

  Future<void> _createPinOnServer(BuildContext context, String pin) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      context.showErrorSnackBar("Token missing. Please log in again.");
      return;
    }

    final res = await _api.createPin(token, pin, pin);
    res.fold(
      (failure) {
        context.showErrorSnackBar(
          failure.properties.isNotEmpty
              ? failure.properties.join('\n')
              : "Failed to create PIN",
        );
      },
      (data) {
        context.showSuccessSnackBar("PIN created successfully");
        onCompleted?.call(); // Final callback
      },
    );
  }

  String? validatePassword(String? input) {
    if (input == null || input.trim().isEmpty) return 'Password required';
    return null;
  }

  Future<String?> validatePasswordAsync() async {
    final input = passwordController.text.trim();
    final storedPassword = await _storage.getPassword();
    if (storedPassword == null || storedPassword != input) {
      return 'Incorrect password';
    }
    return null;
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
