import 'package:bundlegram/core/extensions/context_extensions.dart';
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
  // All text controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  // Country code selection
  String _selectedCountryCode = '+234'; // Default to Nigeria

  // List of common country codes
  final List<Map<String, String>> _countryCodes = [
    {'code': '+1', 'country': 'US'},
    {'code': '+44', 'country': 'UK'},
    {'code': '+234', 'country': 'NG'},
    {'code': '+33', 'country': 'FR'},
    {'code': '+49', 'country': 'DE'},
    {'code': '+81', 'country': 'JP'},
    {'code': '+86', 'country': 'CN'},
    {'code': '+91', 'country': 'IN'},
    {'code': '+61', 'country': 'AU'},
    {'code': '+55', 'country': 'BR'},
    {'code': '+7', 'country': 'RU'},
    {'code': '+39', 'country': 'IT'},
    {'code': '+34', 'country': 'ES'},
    {'code': '+31', 'country': 'NL'},
    {'code': '+46', 'country': 'SE'},
    {'code': '+47', 'country': 'NO'},
    {'code': '+45', 'country': 'DK'},
    {'code': '+358', 'country': 'FI'},
    {'code': '+41', 'country': 'CH'},
    {'code': '+43', 'country': 'AT'},
  ];

  @override
  void initState() {
    super.initState();
    // Add listeners to all controllers
    _firstNameController.addListener(_validateForm);
    _lastNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // Dispose all controllers
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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

  Widget _buildCountryCodeDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: AppColors.greyD0,
            width: 1.0,
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCountryCode,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.grey80,
            size: 20.sp,
          ),
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.grey80,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedCountryCode = newValue;
              });
            }
          },
          items: _countryCodes
              .map<DropdownMenuItem<String>>((Map<String, String> country) {
            return DropdownMenuItem<String>(
              value: country['code'],
              child: Text(
                '${country['country']} ${country['code']}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grey80,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
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
                // if (_formKey.currentState!.validate()) {
                //   // You can access all the form data here
                //   print('First Name: ${_firstNameController.text}');
                //   print('Last Name: ${_lastNameController.text}');
                //   print('Email: ${_emailController.text}');
                //   print('Phone: $_selectedCountryCode${_phoneController.text}');
                //   print('Password: ${_passwordController.text}');

                // }
                context.go(RouteConstants.chooseUsername);
              },
              buttonText: 'Continue',
              formKey: _formKey,
              children: [
                AppTextField(
                  hintText: 'First name',
                  controller: _firstNameController,
                  validateFunction: Validators.userName(),
                ),
                AppTextField(
                  hintText: 'Last name',
                  controller: _lastNameController,
                  validateFunction: Validators.userName(),
                ),
                AppTextField(
                  hintText: 'Email address',
                  controller: _emailController,
                  validateFunction: Validators.email(),
                  keyboardType: TextInputType.emailAddress,
                ),
                AppTextField(
                  hintText: 'Phone number ',
                  controller: _phoneController,
                  validateFunction: Validators.phone(),
                  keyboardType: TextInputType.phone,
                  prefixIcon: Padding(
                    padding: context.symmetricPadding(24, 12),
                    child: Text('+234', style: context.textTheme.bodyMedium),
                  ),
                ),
                AppTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                  validateFunction: Validators.password(),
                  obscureText: true,
                ),
                AppTextField(
                  hintText: 'Confirm Password',
                  controller: _confirmPasswordController,
                  validateFunction: Validators.confirmPass(
                    _passwordController.text,
                    _confirmPasswordController.text,
                  ),
                  obscureText: true,
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
