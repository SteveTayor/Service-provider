import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangepasswordScreen extends StatefulWidget {
  const ChangepasswordScreen({super.key});

  @override
  State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  validateform() {
    setState(() {
      _isFormValid = _formKey.currentState!.validate();
    });
    if (_isFormValid) {
      // show a green success bar
      context.showCustomSnackBar("Password has been updated!");
      context.pop();
    } else {
      // show a red error bar
      context.showErrorSnackBar("Please enter valid passwords.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Change password',
      ),
      body: Column(
        children: [
          Flexible(
            child: AppForm(
              isExpanded: false,
              isActive: _isFormValid,
              onPressed: () {
                // context.go(RouteConstants.dashboard);
                validateform();
              },
              buttonText: 'Update password',
              formKey: _formKey,
              children: [
                AppTextField(
                  obscureText: true,
                  hintText: 'Current password',
                  validateFunction: Validators.passcode(),
                ),
                AppTextField(
                  obscureText: true,
                  hintText: 'New Password',
                  validateFunction: Validators.password(),
                ),
                AppTextField(
                  obscureText: true,
                  hintText: 'New Password again',
                  validateFunction: Validators.password(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
