import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/phone_number_formatter.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/register_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(registerProvider);
    final ctrl = ref.read(registerProvider);
    return BundlegramScaffold(
      resizeToAvoidBottomInset: true,
      sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      // appBar: const BundlegramAppbar(),
      body: Column(
        children: [
          Column(
            children: [
              Text(
                "Let's get started!",
                style: context.textTheme.titleMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account? ',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.grey33,
                      // fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.go('/login');
                      // context.push('/login');
                    },
                    child: Text(
                      'Sign in.',
                      style: context.textTheme.bodyMedium!.copyWith(
                        // fontSize: 16,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          40.verticalSpace,
          Expanded(
            child: AppForm(
              formKey: ctrl.formKey,
              isActive: prov.isValid && !prov.isLoading,
              buttonText: prov.isLoading ? 'Loading...' : 'Continue',
              onPressed: () => ctrl.submit(context),
              children: [
                AppTextField(
                  hintText: 'First name',
                  controller: ctrl.firstNameCtrl,
                  validateFunction: Validators.name(),
                  textInputAction: TextInputAction.next,
                ),
                AppTextField(
                  hintText: 'Last name',
                  controller: ctrl.lastNameCtrl,
                  validateFunction: Validators.name(),
                  textInputAction: TextInputAction.next,
                ),
                AppTextField(
                  hintText: 'Email address',
                  controller: ctrl.emailCtrl,
                  validateFunction: Validators.email(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                AppTextField(
                  hintText: 'Phone number',
                  controller: ctrl.phoneCtrl,
                  validateFunction: Validators.validateNigerianPhoneNumber(),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    NumberInputFormatter(),
                    LengthLimitingTextInputFormatter(
                        10), // Limits input to 10 digits
                  ],
                  prefixIcon: Padding(
                    padding: context.symmetricPadding(20, 12),
                    child: Text('+234', style: context.textTheme.bodySmall),
                  ),
                ),
                AppTextField(
                  hintText: 'Password',
                  controller: ctrl.passwordCtrl,
                  validateFunction: Validators.password(),
                  obscureText: !prov.showPassword,
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        setState(() => prov.showPassword = !prov.showPassword),
                    child: Icon(
                      prov.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grey33,
                      size: 24,
                    ),
                  ),
                ),
                AppTextField(
                  hintText: 'Confirm Password',
                  controller: ctrl.confirmCtrl,
                  onChange:
                      Validators.confirmPass(ctrl.passwordCtrl.text.trim()),
                  obscureText: !prov.showConfirm,
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        setState(() => prov.showConfirm = !prov.showConfirm),
                    child: Icon(
                      prov.showConfirm
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grey33,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          40.verticalSpace,
          RichText(
            text: TextSpan(
              text: 'By continuing, you agree to the ',
              style: context.textTheme.bodySmall,
              children: [
                TextSpan(
                  text: 'Terms and Conditions',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.push(RouteConstants.termsCondition);
                      ctrl.markTermsTapped();
                    },
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryColor,
                    color: AppColors.primaryColor,
                  ),
                ),
                const TextSpan(text: ' and'),
                TextSpan(
                  text: ' Privacy Policy',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.push(RouteConstants.privacyPolicy);
                      ctrl.markPrivacyTapped();
                    },
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryColor,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
