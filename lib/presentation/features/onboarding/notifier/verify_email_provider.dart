import 'dart:async';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/models/base/base_response.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/email_otp_widget.dart';
import 'package:bundlegram/presentation/features/dashboard/screens/dashboard_screen.dart';
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

  void resetState() {
    _sending = false;
    _verifying = false;
    otpCtrl.clear();
    notifyListeners();
  }

  /// Step 1: Send the OTP to the user’s email
  Future<bool> sendEmailOtp(BuildContext context) async {
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
        final userMsg = userFacingMessageFromFailure(fail);
        context.showErrorSnackBar(userMsg);
        _sending = false;
        notifyListeners();
        return false;
      },
      (BaseResponse resp) {
        if (resp.success) {
          context.showSuccessSnackBar(resp.message ?? 'OTP sent');
          _sending = false;
          otpCtrl.clear();
          context.pop();
          // Safely open new dialog in next frame
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   if (Navigator.canPop(context)) {
          //     context.pop(); // dismiss the current bottom sheet
          //   }
          //   EmailOtpDialogNotifier().showOtpInputDialog(context, this);
          // });

          // Delay showing OTP dialog till after pop finishes
          Future.microtask(() {
            EmailOtpDialogNotifier()
                .showOtpInputDialog(navigatorKey.currentContext!, this);
          });

          // Fetch profile to ensure UI updates
          _ref.read(globalProvider.notifier).fetchProfile(context);
          notifyListeners();

          return true;
        } else {
          context.pop();
          final displayMessage =
              resp.message.length > 100 ? resp.message : "Something went wrong";

          context.showErrorSnackBar(displayMessage ?? 'Failed to send OTP');
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
    unawaited(context.showLoadingDialog(message: 'Verifying email'));
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
        context.dismissDialog();
        context.pushReplacement(RouteConstants.dashboard);
        notifyListeners();
        return false;
      },
      (resp) {
        // Check if the response indicates actual success
        if (resp.success) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   context.showPopUp(Text('${resp.message}'));
          // });
          _ref.read(globalProvider.notifier).fetchProfile(context);
          _verifying = false;
          // ✅ Dismiss OTP sheet if still open
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }

          context.showSuccessSnackBar(resp.message ?? 'Email verified');
          // ✅ Navigate after dismiss
          context.pushReplacement(RouteConstants.dashboard);
          otpCtrl.clear();

          context.dismissDialog();
          notifyListeners();
          return true;
        } else {
          context.showErrorSnackBar(resp.message ?? 'Verification failed');
          _verifying = false;
          context.pop();
          context.dismissDialog();
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
