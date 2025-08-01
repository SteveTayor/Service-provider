import 'package:bundlegram/presentation/features/onboarding/notifier/forgot_password_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends ConsumerWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(forgetPasswordProvider);
    final ctrl = ref.read(forgetPasswordProvider);

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(),
      sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Text('Forget Password?', style: context.textTheme.titleMedium),
                Text(
                  'Enter email address used to create account. A code will be sent for verification.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.grey33,
                  ),
                ),
              ],
            ),
            40.verticalSpace,
            AppForm(
              formKey: ctrl.formKey,
              isExpanded: false,
              isActive: prov.isValid && !prov.isLoading,
              onPressed: () {
                FocusScope.of(context).unfocus(); // Dismiss keyboard
                ctrl.submit(context);
              },
              buttonText: prov.isLoading ? 'Sending...' : 'Continue',
              children: [
                AppTextField(
                  hintText: 'Email',
                  controller: ctrl.emailCtrl,
                  validateFunction: Validators.email(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onChange: (value) => ctrl.validate(), // Manual trigger
                ),
              ],
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
