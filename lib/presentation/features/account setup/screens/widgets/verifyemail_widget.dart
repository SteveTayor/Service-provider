// lib/presentation/features/account_setup/screens/verify_email_widget.dart
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/email_otp_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/verify_email_provider.dart';

class VerifyEmailWidget extends ConsumerStatefulWidget {
  const VerifyEmailWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<VerifyEmailWidget> createState() => _VerifyEmailWidgetState();
}

class _VerifyEmailWidgetState extends ConsumerState<VerifyEmailWidget> {
  late TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(globalProvider).profile;
    final userEmail = profile.value?.data?.email ?? '';
    _emailCtrl = TextEditingController(text: userEmail);
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext innerContext) {
        final provider = ref.watch(verifyEmailProvider);
        final notifier = ref.read(verifyEmailProvider.notifier);

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Verify email',
                style: innerContext.textTheme.headlineMedium!
                    .copyWith(color: AppColors.black),
              ),
              12.verticalSpace,
              Text(
                'Please, confirm your email address to receive a verification code.',
                textAlign: TextAlign.center,
                style: innerContext.textTheme.bodySmall,
              ),
              24.verticalSpace,
              AppTextField(
                controller: _emailCtrl,
                readOnly: true,
              ),
              40.verticalSpace,
              BundlegramButton(
                text: provider.sending ? 'Sending...' : 'Confirm email',
                onPressed: provider.sending
                    ? null
                    : () async {
                        await notifier.sendEmailOtp(context);
                      },
              ),
              24.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
