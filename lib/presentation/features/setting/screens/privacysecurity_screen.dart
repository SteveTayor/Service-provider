import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/setting/screens/securityConfirmation_screen.dart';
import 'package:bundlegram/presentation/features/setting/screens/widget/listtileswitch_widget.dart';
import 'package:bundlegram/presentation/features/setting/screens/widget/popUp_reusable.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
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
  bool isLoading = false;

  // Track which toggle is being processed
  SecurityToggleType? pendingToggle;
  bool pendingValue = false;

  void _showSecurityBottomSheet({
    required String header,
    required String content,
    required String buttonTitle,
    required VoidCallback onConfirm,
  }) {
    context.showBottomSheet(
      child: SecurityPopWidget(
        popHeader: header,
        popContent: content,
        popButtonTitle: buttonTitle,
        onConfirm: onConfirm,
      ),
    );
  }

  void _navigateToSecurityConfirmation(
      SecurityToggleType toggleType, bool value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => SecurityConfirmationScreen(
          onSuccess: () => _applySecurityToggle(toggleType, value),
          onCancel: () => _resetLoadingState(), // Add cancel callback
          securityType: _getSecurityTypeDisplayName(toggleType),
        ),
      ),
    );
  }

  void _resetLoadingState() {
    if (mounted) {
      setState(() {
        isLoading = false;
        pendingToggle = null;
      });
    }
  }

  String _getSecurityTypeDisplayName(SecurityToggleType type) {
    switch (type) {
      case SecurityToggleType.faceId:
        return 'Face ID Login';
      case SecurityToggleType.fingerprintLogin:
        return 'Fingerprint Login';
      case SecurityToggleType.fingerprintPayment:
        return 'Fingerprint Payment';
    }
  }

  void _applySecurityToggle(SecurityToggleType toggleType, bool value) {
    setState(() {
      switch (toggleType) {
        case SecurityToggleType.faceId:
          useFaceId = value;
          break;
        case SecurityToggleType.fingerprintLogin:
          useFingerprint = value;
          break;
        case SecurityToggleType.fingerprintPayment:
          useFingerprintForPayment = value;
          break;
      }
      // Clear loading state immediately
      pendingToggle = null;
      isLoading = false;
    });

    // Show success message
    if (mounted) {
      context.showCustomSnackBar(
          '${_getSecurityTypeDisplayName(toggleType)} ${value ? 'enabled' : 'disabled'} successfully');
    }
  }

  void _handleSecurityToggle(SecurityToggleType toggleType, bool value) {
    if (isLoading) return; // Prevent multiple simultaneous operations

    setState(() {
      pendingToggle = toggleType;
      pendingValue = value;
      isLoading = true;
    });

    if (value) {
      // Show confirmation bottom sheet before enabling
      final config = _getToggleConfig(toggleType);
      _showSecurityBottomSheet(
        header: config['header']!,
        content: config['content']!,
        buttonTitle: 'Proceed',
        onConfirm: () {
          context.pop(); // Close bottom sheet
          _navigateToSecurityConfirmation(toggleType, value);
        },
      );
    } else {
      // For disabling, navigate directly to confirmation
      _navigateToSecurityConfirmation(toggleType, value);
    }
  }

  Map<String, String> _getToggleConfig(SecurityToggleType toggleType) {
    switch (toggleType) {
      case SecurityToggleType.faceId:
        return {
          'header': 'Use Face ID to log in',
          'content':
              'Are you sure you want to enable your Face ID to log in on Bundlegram app?',
        };
      case SecurityToggleType.fingerprintLogin:
        return {
          'header': 'Use fingerprint to log in',
          'content':
              'Are you sure you want to enable fingerprint to log in on Bundlegram app?',
        };
      case SecurityToggleType.fingerprintPayment:
        return {
          'header': 'Use fingerprint for payment',
          'content':
              'Are you sure you want to enable fingerprint for payment on Bundlegram app?',
        };
    }
  }

  void _handleFaceIdToggle(bool value) {
    _handleSecurityToggle(SecurityToggleType.faceId, value);
  }

  void _handleFingerprintToggle(bool value) {
    _handleSecurityToggle(SecurityToggleType.fingerprintLogin, value);
  }

  void _handleFingerprintPaymentToggle(bool value) {
    _handleSecurityToggle(SecurityToggleType.fingerprintPayment, value);
  }

  // Handle back navigation - reset pending state if user cancels
  void _onPopInvoked(bool didPop) {
    if (isLoading && pendingToggle != null) {
      _resetLoadingState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: _onPopInvoked,
      child: BundlegramScaffold(
        appBar: const BundlegramAppbar(
          titleText: 'Privacy & Security',
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListtileswitchWidget(
                  title: 'Use Face ID to log in',
                  label:
                      'A face recognition scan will be done anytime you log in to your account.',
                  switchValue: useFaceId,
                  onToggle: _handleFaceIdToggle,
                  // isLoading:
                  //     isLoading && pendingToggle == SecurityToggleType.faceId,
                ),
                ListtileswitchWidget(
                  title: 'Use fingerprint to log in',
                  label: 'Enable your fingerprint to log in the app',
                  switchValue: useFingerprint,
                  onToggle: _handleFingerprintToggle,
                  // isLoading: isLoading &&
                  //     pendingToggle == SecurityToggleType.fingerprintLogin,
                ),
                ListtileswitchWidget(
                  title: 'Use fingerprint for payment',
                  label:
                      'You can make payment with your fingerprint instead of account pin.',
                  switchValue: useFingerprintForPayment,
                  onToggle: _handleFingerprintPaymentToggle,
                  // isLoading: isLoading &&
                  //     pendingToggle == SecurityToggleType.fingerprintPayment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
