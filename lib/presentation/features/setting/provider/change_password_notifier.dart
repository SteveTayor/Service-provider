import 'dart:async';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

final changePasswordProvider = ChangeNotifierProvider.autoDispose
    .family<ChangePasswordController, String>((ref, email) {
  return ChangePasswordController(
    ref,
    ref.read(apiServiceProvider),
    ref.read(secureStorageHelperProvider),
    email,
  );
});

class ChangePasswordController extends ChangeNotifier {
  ChangePasswordController(this._ref, this._api, this._storage, this.email) {
    currentPasswordController.addListener(validateForm);
    newPasswordController.addListener(validateForm);
    confirmPasswordController.addListener(validateForm);
    WidgetsBinding.instance.addPostFrameCallback((_) => validateForm());
  }
  String email;

  final Ref _ref;
  final ApiService _api;
  final SecureStorageHelper _storage;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  bool isLoading = false;
  bool showCurrentPassword = true;
  bool showNewPassword = true;
  bool showConfirmPassword = true;

  // âœ… Add getter to determine if new password fields should be enabled
  bool get enableNewPasswordFields =>
      currentPasswordController.text.trim().length >= 6;

  void validateForm() {
    final formIsValid = formKey.currentState?.validate() ?? false;

    // âœ… Only enable submit button when form is valid AND all required fields have input
    isFormValid = formIsValid &&
        currentPasswordController.text.trim().isNotEmpty &&
        newPasswordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty;

    notifyListeners();
  }

  void toggleCurrentPasswordVisibility() {
    showCurrentPassword = !showCurrentPassword;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    showNewPassword = !showNewPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!isFormValid || isLoading) {
      if (!isFormValid) {
        context.showErrorSnackBar('Please enter valid passwords.');
      }
      return;
    }

    isLoading = true;
    notifyListeners();

    context.showLoadingDialog(message: 'Updating password...');

    final token = await _storage.getAuthToken();
    if (token == null) {
      context
        ..dismissDialog()
        ..showErrorSnackBar('Token missing. Please log in again.');
      isLoading = false;
      notifyListeners();
      return;
    }

    final res = await _api.newPassword(
      email,
      newPasswordController.text.trim(),
      confirmPasswordController.text.trim(),
    );

    context.dismissDialog();

    res.fold(
      (failure) {
        final userMsg = userFacingMessageFromFailure(failure);
        final displayMsg = sanitizeErrorMessage(userMsg);
        context.showErrorSnackBar(displayMsg);
      },
      (data) async {
        isLoading = false;
        context.showSuccessSnackBar('Password has been updated!');
        await Future.delayed(const Duration(milliseconds: 300));
        if (context.mounted) {
          debugPrint("Login in...");
          context.go(RouteConstants.login);
        }
        notifyListeners();
      },
    );

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    currentPasswordController
      ..removeListener(validateForm)
      ..dispose();
    newPasswordController
      ..removeListener(validateForm)
      ..dispose();
    confirmPasswordController
      ..removeListener(validateForm)
      ..dispose();
    super.dispose();
  }
}

