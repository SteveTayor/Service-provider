import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/resetpasswordlink_screen.dart';
import 'package:bundlegram/presentation/features/setting/provider/create_pin_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetAccountPin extends ConsumerStatefulWidget {
  const ResetAccountPin({super.key});

  @override
  ConsumerState<ResetAccountPin> createState() => _ResetAccountPinState();
}

class _ResetAccountPinState extends ConsumerState<ResetAccountPin> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final userEmail = ref.watch(globalProvider).profile.value?.data?.email;

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Enter your password',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Flexible(
            child: AppForm(
              isExpanded: false,
              isActive: !_isSubmitting,
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;

                setState(() => _isSubmitting = true);

                final password = _passwordController.text.trim();
                final controller = ref.read(pinControllerProvider.notifier);

                await controller
                    .resetPinWithPassword(password, context)
                    .then((success) {
                  if (success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResetPasswordLinkScreen(
                          title: 'Reset link sent!',
                          subtitle:
                              'Your account pin reset link has been sent to your email - $userEmail. Check your inbox and click the link to reset your pin.',
                        ),
                      ),
                    );
                  }
                });

                setState(() => _isSubmitting = false);
              },
              buttonText: 'Continue',
              formKey: _formKey,
              children: [
                AppTextField(
                  controller: _passwordController,
                  obscureText: true,
                  hintText: 'Password',
                  // validateFunction: Validators.password(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
