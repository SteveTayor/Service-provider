import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/setting/screens/widget/listtileswitch_widget.dart';
import 'package:bundlegram/presentation/features/setting/screens/widget/popUp_reusable.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PrivacysecurityScreen extends StatefulWidget {
  const PrivacysecurityScreen({super.key});

  @override
  State<PrivacysecurityScreen> createState() => _PrivacysecurityScreenState();
}

class _PrivacysecurityScreenState extends State<PrivacysecurityScreen> {
  bool useFaceId = false;
  bool useFingerprint = false;
  bool useFingerprintForPayment = false;

  void _showSecurityPopup({
    required String header,
    required String content,
    required String buttonTitle,
    required VoidCallback onConfirm,
  }) {
    context.showPopUp(
      SecurityPopWidget(
        popHeader: header,
        popContent: content,
        popButtonTitle: buttonTitle,
        onConfirm: onConfirm,
      ),
    );
  }

  void _handleFaceIdToggle(bool value) {
    if (value) {
      _showSecurityPopup(
        header: 'Use Face ID to log in',
        content:
            'Are you sure you want to enable your Face ID to log in on Bundlegram app?',
        buttonTitle: 'Proceed',
        onConfirm: () {
          setState(() {
            useFaceId = true;
          });
          Navigator.of(context).pop(); // Close popup
        },
      );
    } else {
      setState(() {
        useFaceId = false;
      });
    }
  }

  void _handleFingerprintToggle(bool value) {
    if (value) {
      _showSecurityPopup(
        header: 'Use fingerprint to log in',
        content:
            'Are you sure you want to enable fingerprint to log in on Bundlegram app?',
        buttonTitle: 'Proceed',
        onConfirm: () {
          setState(() {
            useFingerprint = true;
          });
          Navigator.of(context).pop(); // Close popup
        },
      );
    } else {
      setState(() {
        useFingerprint = false;
      });
    }
  }

  void _handleFingerprintPaymentToggle(bool value) {
    if (value) {
      _showSecurityPopup(
        header: 'Use fingerprint for payment',
        content:
            'Are you sure you want to enable fingerprint for payment on Bundlegram app?',
        buttonTitle: 'Proceed',
        onConfirm: () {
          setState(() {
            useFingerprintForPayment = true;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => SecurityConfirmationScreen(),
            ),
          );
        },
      );
    } else {
      setState(() {
        useFingerprintForPayment = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Privacy & Security',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListtileswitchWidget(
            title: 'Use Face ID to log in',
            label:
                'A face recognition scan will be done anytime you log in to your account.',
            switchValue: useFaceId,
            onToggle: _handleFaceIdToggle,
          ),
          ListtileswitchWidget(
            title: 'Use fingerprint to log in',
            label: 'Enable your fingerprint to log in the app',
            switchValue: useFingerprint,
            onToggle: _handleFingerprintToggle,
          ),
          ListtileswitchWidget(
            title: 'Use fingerprint for payment',
            label:
                'You can make payment with your fingerprint instead of account pin.',
            switchValue: useFingerprintForPayment,
            onToggle: _handleFingerprintPaymentToggle,
          ),
        ],
      ),
    );
  }
}

class SecurityConfirmationScreen extends StatefulWidget {
  const SecurityConfirmationScreen({super.key});

  @override
  State<SecurityConfirmationScreen> createState() =>
      _SecurityConfirmationScreenState();
}

class _SecurityConfirmationScreenState
    extends State<SecurityConfirmationScreen> {
  final bool _isFormValid = false;
  final _formKey = GlobalKey<FormState>();
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
                context.push(RouteConstants.dashboard);
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
