import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CloseAccountScreen extends StatefulWidget {
  const CloseAccountScreen({super.key});

  @override
  State<CloseAccountScreen> createState() => _CloseAccountScreenState();
}

class _CloseAccountScreenState extends State<CloseAccountScreen> {
  bool _isFormValid = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Enter your password',
      ),
      body: Column(
        children: [
          Divider(),
          16.verticalSpace,
          Flexible(
            child: AppForm(
              isExpanded: false,
              isActive: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => TransactionSuccessful(
                      title: 'Request received!',
                      subTitle:
                          'Your request to close your account has been submitted, an email will be sent to you within 7 working days, thank you for using Bundlegram.',
                      isCloseAccount: true,
                    ),
                  ),
                );
              },
              buttonColor: AppColors.logOut,
              buttonText: 'Close account',
              formKey: _formKey,
              children: [
                AppTextField(
                  obscureText: true,
                  hintText: 'Password',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
