import 'package:bundlegram/presentation/general_widget/custom_snackbar.dart';
import 'package:flutter/material.dart';

extension CustomSnackBarExtension on BuildContext {
  void showCustomSnackBar(String message) {
    CustomSnackBar.show(this, message);
  }

  void showErrorSnackBar(String message) {
    CustomSnackBar.showError(this, message);
  }

  void showSuccessSnackBar(String message) {
    CustomSnackBar.showSuccess(this, message);
  }

  void showWarningSnackBar(String message) {
    CustomSnackBar.showWarning(this, message);
  }
}