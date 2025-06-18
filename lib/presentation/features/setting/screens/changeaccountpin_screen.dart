import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/setting/screens/pin_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangeaccountpinScreen extends StatefulWidget {
  const ChangeaccountpinScreen({super.key});

  @override
  State<ChangeaccountpinScreen> createState() => _ChangeaccountpinScreenState();
}

class _ChangeaccountpinScreenState extends State<ChangeaccountpinScreen> {
  final _formKey = GlobalKey<FormState>();
  final bool _isFormValid = false;

  _navigateToSuccessScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const TransactionSuccessful(
          title: 'Account pin changed!',
          subTitle:
              'You can use your new account PIN when performing transactions.',
        ),
      ),
    );
  }

  navigateToAccountPinCreated() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const TransactionSuccessful(
          isBasicInfo: true,
          title: 'Account pin created!',
          subTitle:
              'You can now use your account PIN when performing transactions.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => EnterPinScreen(
                      isChangedAccountPin: true,
                      onVerified: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PinScreen(
                              mode: PinScreenMode.create,
                              onCompleted: () {
                                // Navigate to your success screens
                                _navigateToSuccessScreen();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
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
