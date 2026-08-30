// lib/presentation/features/onboarding/notifier/forgot_password_provider.dart
import 'dart:async';
import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/widgets/forgotpassword_otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

final forgetPasswordProvider = ChangeNotifierProvider((ref) {
  final api = ref.read(apiServiceProvider);
  final storage = ref.read(secureStorageHelperProvider);
  return ForgetPasswordProvider(api, storage);
});

class ForgetPasswordProvider extends ChangeNotifier {
  final ApiService _api;
  final SecureStorageHelper _storage;

  ForgetPasswordProvider(this._api, this._storage) {
    emailCtrl.addListener(validate);
    otpCtrl.addListener(validateOtp);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      validate();
    });
  }

  final emailCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  bool _isValid = false;
  bool _isLoading = false;
  bool _verifyingOtp = false;
  bool _isOtpValid = false;

  bool get isValid => _isValid;
  bool get isLoading => _isLoading;
  bool get verifyingOtp => _verifyingOtp;
  bool get isOtpValid => _isOtpValid;

  void validate() {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid != _isValid) {
      _isValid = valid;
      notifyListeners();
    }
  }

  void validateOtp() {
    final valid = otpFormKey.currentState?.validate() ?? false;
    if (valid != _isOtpValid) {
      _isOtpValid = valid;
      notifyListeners();
    }
  }

  Future<void> submit(BuildContext context) async {
    if (!_isValid) {
      return;
    }
    final email = emailCtrl.text.trim();
    _isLoading = true;
    notifyListeners();

    if (context.mounted) {
      unawaited(context.showLoadingDialog(message: 'Sending reset OTP...'));
    }
    final result = await _api.forgetPassword(email);
    if (context.mounted) {
      context.dismissDialog();
    }

    result.fold(
      (fail) {
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Failed to send reset OTP';
        if (context.mounted) {
          context.showErrorSnackBar(message);
        }
      },
      (data) {
        if (context.mounted) {
          context.showCustomSnackBar(data.message);
          ForgotPasswordOtpDialog().showOtpInputDialog(context, this);
        }
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<void> verifyForgotPasswordOtp(BuildContext context) async {
    if (!_isOtpValid) {
      return;
    }
    final email = emailCtrl.text.trim();
    final otp = otpCtrl.text.trim();
    _verifyingOtp = true;
    notifyListeners();

    if (context.mounted) {
      unawaited(context.showLoadingDialog(message: 'Verifying OTP...'));
    }

    // Retrieve token
    final token = await _storage.getAuthToken();
    if (token == null) {
      if (context.mounted) {
        context
          ..dismissDialog()
          ..showErrorSnackBar('Missing authentication token');
      }
      _verifyingOtp = false;
      notifyListeners();
      return;
    }

    final result = await _api.verifyOtp(
      token,
      VerifyOtpRequest(email: email, otp: otp),
    );
    if (context.mounted) {
      context.dismissDialog();
    }

    result.fold(
      (fail) {
        final userMsg = userFacingMessageFromFailure(fail);
        context.showErrorSnackBar(userMsg);
        if (context.mounted) {
          context.showErrorSnackBar(userMsg);
        }
      },
      (data) {
        if (context.mounted) {
          context
            ..showCustomSnackBar(data.message)
            // ..pop() // Close the OTP dialog
            ..push(RouteConstants.changePassword, extra: email);
        }
      },
    );
    _verifyingOtp = false;
    notifyListeners();
  }

  /// Opens the default email app
  Future<void> openEmailApp() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: '',
    );

    // if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
    // } else {
    //   debugPrint('Could not open email app.');
    // }
  }

  @override
  void dispose() {
    emailCtrl.removeListener(validate);
    emailCtrl.dispose();
    otpCtrl.removeListener(validateOtp);
    otpCtrl.dispose();
    super.dispose();
  }
}

