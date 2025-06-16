import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController controller = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  bool rememberMe = false;
  bool showPassword = true;
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
                'Welcome back!',
                style: context.textTheme.titleMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No account yet? ',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.grey33,
                      fontSize: 16.sp,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push('/register');
                    },
                    child: Text(
                      'Sign up.',
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
          Flexible(
            child: AppForm(
              isExpanded: false,
              extraWidget: Row(
                children: [
                  Checkbox(
                    checkColor: AppColors.white,
                    side: const BorderSide(color: AppColors.primaryColor),
                    value: rememberMe,
                    onChanged: (c) {
                      setState(() {
                        rememberMe = c!;
                      });
                    },
                  ),
                  Text(
                    'Remember me',
                    style: context.textTheme.bodySmall!.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.grey83,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => context.push(
                      RouteConstants.forgetPassword,
                    ),
                    child: Text(
                      'Forget Password?',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              isActive: _isFormValid,
              onPressed: () {
                context.go(RouteConstants.dashboard);
              },
              buttonText: 'Sign In',
              formKey: _formKey,
              children: [
                AppTextField(
                  hintText: 'Email address',
                  validateFunction: Validators.email(),
                ),
                AppTextField(
                  obscureText: showPassword,
                  hintText: 'Password',
                  suffixIcon: AppSvgIcon(
                    path: Assets.svgs.eye,
                    fit: BoxFit.scaleDown,
                  ),
                  validateFunction: Validators.password(),
                ),
              ],
            ),
          ),
          40.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: AppSvgIcon(path: Assets.svgs.fingerCricle)),
              8.horizontalSpace,
              Flexible(
                child: Text(
                  textAlign: TextAlign.center,
                  'Sign in with fingerprint / face ID',
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
