import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final changePasswordProvider =
    ChangeNotifierProvider.autoDispose<ChangePasswordController>((ref) {
  return ChangePasswordController(
    ref,
    ref.read(apiServiceProvider),
    ref.read(secureStorageHelperProvider),
  );
});

class ChangePasswordController extends ChangeNotifier {
  ChangePasswordController(this._ref, this._api, this._storage);

  final Ref _ref;
  final ApiService _api;
  final SecureStorageHelper _storage;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;

  Future<void> validateForm(BuildContext context) async {
    isFormValid = formKey.currentState?.validate() ?? false;
    notifyListeners();

    if (isFormValid) {
      final token = await _storage.getAuthToken();
      if (token == null) {
        context.showErrorSnackBar("Token missing. Please log in again.");
        return;
      }

      final res = await _api.changePassword(
        token,
        currentPasswordController.text.trim(),
        newPasswordController.text.trim(),
      );

      res.fold(
        (failure) {
          context.showErrorSnackBar(
            failure.properties.isNotEmpty
                ? failure.properties.join('\n')
                : "Failed to update password",
          );
        },
        (data) {
          context.showCustomSnackBar("Password has been updated!");
          context.pop();
        },
      );
    } else {
      context.showErrorSnackBar("Please enter valid passwords.");
    }
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
