import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/features/biometric/providers/biometric_service.dart';
import 'package:bundlegram/presentation/features/setting/provider/security_provider.dart';
import 'package:bundlegram/presentation/features/setting/screens/securityConfirmation_screen.dart';
import 'package:bundlegram/presentation/features/setting/screens/widget/listtileswitch_widget.dart';
import 'package:bundlegram/presentation/features/setting/screens/widget/popUp_reusable.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PrivacysecurityScreen extends ConsumerStatefulWidget {
  const PrivacysecurityScreen({super.key});

  @override
  ConsumerState<PrivacysecurityScreen> createState() =>
      _PrivacysecurityScreenState();
}

class _PrivacysecurityScreenState extends ConsumerState<PrivacysecurityScreen> {
  bool isLoading = false;
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
          onCancel: _resetLoadingState,
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

  Future<void> _applySecurityToggle(
      SecurityToggleType toggleType, bool value) async {
    final biometricService = ref.read(biometricServiceProvider);
    final securityNotifier = ref.read(securityProvider.notifier);

    // Update notifier immediately for UI feedback
    if (toggleType == SecurityToggleType.faceId ||
        toggleType == SecurityToggleType.fingerprintLogin) {
      securityNotifier.useFaceId = value;
    } else if (toggleType == SecurityToggleType.fingerprintPayment) {
      securityNotifier.useFingerprintForPayment = value;
    }

    // Then persist async
    if (value) {
      if (toggleType == SecurityToggleType.faceId ||
          toggleType == SecurityToggleType.fingerprintLogin) {
        await biometricService.enableBiometricLogin();
      } else {
        await biometricService.enableBiometricTransaction();
      }
    } else {
      if (toggleType == SecurityToggleType.faceId ||
          toggleType == SecurityToggleType.fingerprintLogin) {
        await biometricService.disableBiometricLogin();
      } else {
        await biometricService.disableBiometricTransaction();
      }
    }

    if (mounted) {
      setState(() {
        pendingToggle = null;
        isLoading = false;
      });
      context.showCustomSnackBar(
        '${_getSecurityTypeDisplayName(toggleType)} ${value ? 'enabled' : 'disabled'} successfully',
      );
    }
  }

  Future<void> _handleSecurityToggle(
      SecurityToggleType toggleType, bool value) async {
    if (isLoading) return;

    final biometricService = ref.read(biometricServiceProvider);
    final secureStorage = ref.read(secureStorageHelperProvider);

    if (!await biometricService.isAvailable()) {
      context.showErrorSnackBar(
          'Biometric authentication is not available on this device');
      return;
    }

    setState(() {
      pendingToggle = toggleType;
      pendingValue = value;
      isLoading = true;
    });

    final email = await secureStorage.getRememberedEmail();
    if (email == null) {
      _resetLoadingState();
      context.showErrorSnackBar('No remembered email found');
      return;
    }

    final hasPin = await secureStorage.getPin(email) != null;
    if (!hasPin) {
      _resetLoadingState();
      context.showErrorSnackBar('Please set your transaction PIN first');
      return;
    }

    if (value &&
        (toggleType == SecurityToggleType.faceId ||
            toggleType == SecurityToggleType.fingerprintLogin)) {
      final hasCredentials = await biometricService.hasBiometricCredentials();
      // if (!hasCredentials) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (ctx) => BiometricSetupScreen(
      //         onSuccess: () => _applySecurityToggle(toggleType, value),
      //         securityType: _getSecurityTypeDisplayName(toggleType),
      //       ),
      //     ),
      //   );
      //   return;
      // }
    }

    if (value) {
      final config = _getToggleConfig(toggleType);
      _showSecurityBottomSheet(
        header: config['header']!,
        content: config['content']!,
        buttonTitle: 'Proceed',
        onConfirm: () {
          context.pop();
          _navigateToSecurityConfirmation(toggleType, value);
        },
      );
    } else {
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

  void _onPopInvoked(bool didPop) {
    if (isLoading && pendingToggle != null) {
      _resetLoadingState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final security = ref.watch(securityProvider);
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
                  switchValue: security.useFaceId,
                  onToggle: _handleFaceIdToggle,
                ),
                ListtileswitchWidget(
                  title: 'Use fingerprint to log in',
                  label: 'Enable your fingerprint to log in the app',
                  switchValue: security.useFingerprint,
                  onToggle: _handleFingerprintToggle,
                ),
                ListtileswitchWidget(
                  title: 'Use fingerprint for payment',
                  label:
                      'You can make payment with your fingerprint instead of account pin.',
                  switchValue: security.useFingerprintForPayment,
                  onToggle: _handleFingerprintPaymentToggle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
