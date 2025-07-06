import 'package:bundlegram/data/models/base/base_response.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/email_otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:dartz/dartz.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:go_router/go_router.dart';

final verifyEmailProvider = ChangeNotifierProvider<VerifyEmailProvider>((ref) {
  return VerifyEmailProvider(ref, ref.read(apiServiceProvider));
});

class VerifyEmailProvider extends ChangeNotifier {
  final Ref _ref;
  final ApiService _api;

  VerifyEmailProvider(this._ref, this._api);

  final formKey = GlobalKey<FormState>();
  final TextEditingController otpCtrl = TextEditingController();

  bool _sending = false;
  bool get sending => _sending;

  bool _verifying = false;
  bool get verifying => _verifying;

  /// Step 1: Send the OTP to the user’s email
  Future<bool> sendEmailOtp(BuildContext context, WidgetRef ref) async {
    _sending = true;
    notifyListeners();

    final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
    if (token == null) {
      context.showErrorSnackBar('Missing auth token');
      _sending = false;
      notifyListeners();
      return false;
    }

    final result = await _api.sendEmailOtp(token);
    return result.fold(
      (Failure fail) {
        context.showErrorSnackBar(fail.properties.join('\n'));
        _sending = false;
        notifyListeners();
        return false;
      },
      (BaseResponse resp) {
        if (resp.success == true) {
          context.showSuccessSnackBar(resp.message ?? 'OTP sent');
          _sending = false;
          notifyListeners();
          // Handle routing here
          context.pop();
          EmailOtpDialogNotifier().showOtpInputDialog(context, ref);

          return true;
        } else {
          context.pop();

          context.showErrorSnackBar(resp.message ?? 'Failed to send OTP');
          _sending = false;
          notifyListeners();
          return false;
        }
      },
    );
  }

  /// Step 2: Verify the OTP entered by the user
  Future<bool> verifyEmailOtp(BuildContext context) async {
    if (!formKey.currentState!.validate()) return false;

    _verifying = true;
    notifyListeners();

    final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
    if (token == null) {
      context.showErrorSnackBar('Missing auth token');
      _verifying = false;
      notifyListeners();
      return false;
    }

    final req = VerifyEmailRequest(otp: otpCtrl.text.trim());
    final result = await _api.verifyEmail(token, req);

    return result.fold(
      (Failure fail) {
        context.showErrorSnackBar(fail.properties.join('\n'));
        _verifying = false;
        notifyListeners();
        return false;
      },
      (BaseResponse resp) {
        // Check if the response indicates actual success
        if (resp.success == true) {
          context.showSuccessSnackBar(resp.message ?? 'Email verified');
          _ref.read(globalProvider.notifier).fetchProfile(context);
          _verifying = false;
          notifyListeners();
          return true;
        } else {
          context.showErrorSnackBar(resp.message ?? 'Verification failed');
          _verifying = false;
          notifyListeners();
          return false;
        }
      },
    );
  }

  @override
  void dispose() {
    otpCtrl.dispose();
    super.dispose();
  }
}
