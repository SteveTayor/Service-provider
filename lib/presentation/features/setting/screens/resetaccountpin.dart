import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/resetpasswordlink_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Resetaccountpin extends StatefulWidget {
  const Resetaccountpin({super.key});

  @override
  State<Resetaccountpin> createState() => _ResetaccountpinState();
}

class _ResetaccountpinState extends State<Resetaccountpin> {
  final _formKey = GlobalKey<FormState>();
  final bool _isFormValid = false;

  @override
  Widget build(BuildContext context) {
    String userEmail = 'roseowen@gmail.com';
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
              isActive: _isFormValid,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ResetPasswordLinkScreen(
                        title: 'Reset link sent!',
                        subtitle:
                            'Your account pin reset link has been sent to your email - ${userEmail}. Check your inbox and click the link to reset your pin.',
                      ),
                    ),
                  );
                }
              },
              buttonText: 'Continue',
              formKey: _formKey,
              children: [
                AppTextField(
                  obscureText: true,
                  hintText: 'Password',
                  validateFunction: Validators.passcode(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
