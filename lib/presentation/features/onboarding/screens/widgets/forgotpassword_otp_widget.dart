import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/forgot_password_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordOtpDialog {
  Future<void> showOtpInputDialog(
      BuildContext context, ForgetPasswordProvider notifier) async {
    final provider = notifier;

    await context.showBottomSheet(
      child: Form(
        key: provider.otpFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter OTP Sent to Your Email!',
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium,
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
              text: provider.verifyingOtp ? 'Verifying...' : 'Submit',
              onPressed: provider.verifyingOtp
                  ? null
                  : () async {
                      await provider.verifyForgotPasswordOtp(context);
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
