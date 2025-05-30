import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // TextEditingController controller = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isFormValid = false;
  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
  }

  void _validateForm() {
    // Trigger validation on every change
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      appBar: const BundlegramAppbar(),
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
                      fontSize: 16.sp,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push('/login');
                    },
                    child: Text(
                      'Sign in.',
                      style: context.textTheme.bodySmall!.copyWith(
                        fontSize: 16.sp,
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
              isActive: _isFormValid,
              onPressed: () {
                context.go(RouteConstants.chooseUsername);
              },
              buttonText: 'Continue',
              formKey: _formKey,
              children: [
                AppTextField(
                  hintText: 'First name',
                  onChange: (p0) {
                    setState(() {
                      _emailController.text = p0;
                    });
                  },
                  controller: _emailController,
                  validateFunction: Validators.userName(),
                ),
                AppTextField(
                  validateFunction: Validators.userName(),
                  hintText: 'Last name',
                ),
                AppTextField(
                  hintText: 'Email address',
                  validateFunction: Validators.email(),
                ),
                AppTextField(
                  hintText: 'Phone number',
                  validateFunction: Validators.phone(),
                ),
                AppTextField(
                  hintText: 'Password',
                  validateFunction: Validators.password(),
                ),
                AppTextField(
                  hintText: 'Confirm Password',
                  validateFunction: Validators.confirmPass(
                    'Pass123@',
                    'Pass123@',
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
                  text: 'Terms and Conditions ↗',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.push(RouteConstants.termsCondition);
                    },
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryColor,
                    color: AppColors.primaryColor,
                  ),
                ),
                const TextSpan(text: ' and'),
                TextSpan(
                  text: ' Privacy Policy↗',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.push(RouteConstants.privacyPolicy);
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
