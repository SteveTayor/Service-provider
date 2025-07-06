// lib/presentation/features/account_setup/widgets/otp_dialog.dart
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/verify_email_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EmailOtpDialogNotifier {
  Future<void> showOtpInputDialog(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(verifyEmailProvider.notifier);
    final provider = ref.watch(verifyEmailProvider);

    await context.showBottomSheet(
      child: Form(
        key: provider.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter OTP',
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            TextFormField(
              controller: provider.otpCtrl,
              decoration: const InputDecoration(
                hintText: 'OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'OTP is required' : null,
            ),
            BundlegramButton(
              text: "Submit",
              onPressed: provider.verifying
                  ? null
                  : () async {
                      final ok = await notifier.verifyEmailOtp(context);
                      if (ok) context.pop(); // Close if verified
                    },
            )
          ],
        ),
      ),
    );
  }
}
