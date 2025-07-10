import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/resetpasswordlink_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

final forgetPasswordProvider = ChangeNotifierProvider((ref) {
  final api = ref.read(apiServiceProvider);
  return ForgetPasswordProvider(api);
});

class ForgetPasswordProvider extends ChangeNotifier {
  final ApiService _api;
  ForgetPasswordProvider(this._api) {
    emailCtrl.addListener(_validate);
  }

  final emailCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isValid = false;
  bool get isValid => _isValid;

  void _validate() {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid != _isValid) {
      _isValid = valid;
      notifyListeners();
    }
  }

  Future<void> openEmailApp(BuildContext context) async {
    final emailUri = Uri(scheme: 'mailto');
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      context.showCustomSnackBar('No email app found');
    }
  }

  Future<void> submit(BuildContext context) async {
    if (!_isValid) return;
    final email = emailCtrl.text.trim();

    context.showLoadingDialog(message: 'Sending reset link...');
    final result = await _api.forgetPassword(email);
    context.dismissDialog();

    result.fold(
      (fail) {
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Failed to send reset link';
        context.showErrorSnackBar(message);
      },
      (data) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => ResetPasswordLinkScreen(
              title: 'Reset link sent!',
              subtitle:
                  'A password reset link has been sent to your email, $email. Check your inbox and click the link to reset your password.',
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }
}
