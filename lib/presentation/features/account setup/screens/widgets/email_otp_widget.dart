// lib/presentation/features/account_setup/widgets/otp_dialog.dart
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/verify_email_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EmailOtpDialogNotifier {
  Future<void> showOtpInputDialog(
      BuildContext context, VerifyEmailProvider notifier) async {
    final provider = notifier;

    await context.showBottomSheet(
      child: Form(
        key: provider.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter OTP Sent to Your Mail!',
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            AppTextField(
              controller: provider.otpCtrl,
              hintText: 'OTP',
              keyboardType: TextInputType.number,
              validateFunction: (v) =>
                  v == null || v.trim().isEmpty ? 'OTP is required' : null,
            ),
            30.verticalSpace,
            BundlegramButton(
              text: provider.verifying ? 'Verifying...' : 'Submit',
              onPressed: provider.verifying
                  ? null
                  : () async {
                      final success = await provider.verifyEmailOtp(context);
                      if (success) {
                        context.pop();
                      }
                    },
            ),
          ],
        ).withContainer(
          padding: context.symmetricPadding(24, 24),
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }
}
