import 'dart:async';

import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/biometric/providers/biometric_service.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/login_notifier.dart';
import 'package:bundlegram/presentation/features/setting/provider/security_provider.dart';
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

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _showBiometric = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricEnabled();
  }

  Future<void> _checkBiometricEnabled() async {
    final biometricService = ref.read(biometricServiceProvider);
    final security = ref.read(securityProvider);

    final enabled = await biometricService.isBiometricLoginEnabled;
    if (enabled && (security.useFingerprint || security.useFaceId)) {
      setState(() => _showBiometric = true);

      // Prefetch & debug print
      final email = await biometricService.getBiometricEmail();
      final password = await biometricService.getBiometricPassword();
      debugPrint('[Biometric] Prefetch → email=$email, password=$password');
    }
  }

  Future<void> _handleBiometricLogin(BuildContext context) async {
    final biometricService = ref.read(biometricServiceProvider);
    final ctrl = ref.read(loginProvider);

    final authenticated = await biometricService.authenticate(
      type: BiometricAuthType.login,
    );

    if (authenticated) {
      final email = await biometricService.getBiometricEmail();
      final password = await biometricService.getBiometricPassword();

      if (email != null && password != null) {
        ctrl.emailCtrl.text = email;
        ctrl.passwordCtrl.text = password;
        unawaited(ctrl.submit(context)); // trigger normal login flow
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(loginProvider);
    final ctrl = ref.read(loginProvider);
    final biometricService = ref.watch(biometricServiceProvider);
    final security = ref.watch(securityProvider);

    final showBiometric = security.useFingerprint || security.useFaceId;
    return WillPopScope(
      onWillPop: () async {
        debugPrint('onWillPop pressed -> navigate to walkthrough');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(
            RouteConstants.walkThrough,
          ); 
        });
        return false;
      },
      child: BundlegramScaffold(
        sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
        appBar: BundlegramAppbar(
          onTap: (){
             WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(RouteConstants.walkThrough);
        });
          }
        ),
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
                        // fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.go('/register');

                        // context.push('/register');
                      },
                      child: Text(
                        'Sign up.',
                        style: context.textTheme.bodyMedium?.copyWith(
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
            Flexible(
              child: AppForm(
                formKey: ctrl.formKey,
                isExpanded: false,
                extraWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                        // fontSize: 16,
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
                        style: context.textTheme.labelMedium?.copyWith(
                          // fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                isActive: prov.isValid && !prov.isLoading,
                onPressed: () {
                  FocusScope.of(context).unfocus(); // Dismiss keyboard
                  ctrl.submit(context);
                },
                buttonText: prov.isLoading ? 'Loading...' : 'Sign In',
                children: [
                  AppTextField(
                    hintText: 'Email address or username',
                    controller: ctrl.emailCtrl,
                    validateFunction: Validators.emailOrUsername(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  AppTextField(
                    hintText: 'Password',
                    controller: ctrl.passwordCtrl,
                    obscureText: prov.showPasswrd,
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          setState(() => prov.showPasswrd = !prov.showPasswrd),
                      // onTap: () => ctrl.togglePasswordVisibility,
                      child: Icon(
                        prov.showPasswrd
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.grey33,
                        size: 24,
                      ),
                    ),
                    onChange: (value) {
                      ctrl.validate();
                    },
                  ),
                ],
              ),
            ),
            40.verticalSpace,
            if (showBiometric)
              InkWell(
                onTap: () => _handleBiometricLogin(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSvgIcon(path: Assets.svgs.fingerCricle),
                    8.horizontalSpace,
                    Flexible(
                      child: Text(
                        'Sign in with fingerprint / face ID',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
