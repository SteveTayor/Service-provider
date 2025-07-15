import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/login_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(loginProvider);
    final ctrl = ref.read(loginProvider);
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
              formKey: ctrl.formKey,
              isExpanded: false,
              extraWidget: Row(
                children: [
                  Checkbox(
                    value: prov.rememberMe,
                    onChanged: ctrl.toggleRememberMe,
                    activeColor: AppColors.primaryColor,
                    side: const BorderSide(
                      color: AppColors.primaryColor,
                    ),
                    checkColor: AppColors.white,
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
              isActive: prov.isValid && !prov.isLoading,
              onPressed: () => ctrl.submit(context),
              buttonText: prov.isLoading ? 'Loading...' : 'Sign In',
              children: [
                AppTextField(
                  hintText: 'Email address',
                  controller: ctrl.emailCtrl,
                  validateFunction: Validators.email(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                AppTextField(
                  obscureText: prov.showPassword,
                  hintText: 'Password',
                  controller: ctrl.passwordCtrl,
                  suffixIcon: prov.showPassword
                      ? AppSvgIcon(
                          path: Assets.svgs.eye,
                          fit: BoxFit.scaleDown,
                          onTap: ctrl.togglePasswordVisibility,
                        )
                      : const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.visibility_off,
                            size: 24,
                          ),
                        ),
                  validateFunction: Validators.password(),
                  onChange: (value) => ctrl.validate(),
                ),
              ],
            ),
          ),
          40.verticalSpace,
          Visibility(
            visible: false, // biometric toggle off for now
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSvgIcon(path: Assets.svgs.fingerCricle),
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
          ),
        ],
      ),
    );
  }
}
