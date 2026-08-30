import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

enum BiometricAuthType { login, transaction, setup }

final biometricServiceProvider = Provider((ref) => BiometricService(ref));

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final Ref _ref;
  bool _isAuthenticating = false;

  BiometricService(this._ref);

  Future<bool> isAvailable() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();

      debugPrint("[Biometric] canCheckBiometrics = $isAvailable");
      debugPrint("[Biometric] isDeviceSupported = $isDeviceSupported");

      return isAvailable || isDeviceSupported;
    } catch (e) {
      debugPrint("[Biometric] Error checking availability: $e");
      return false;
    }
  }

  Future<void> stopAuthentication() async {
    try {
      await _localAuth.stopAuthentication();
      debugPrint("[Biometric] stopAuthentication called");
    } catch (e) {
      debugPrint("[Biometric] stopAuthentication error: $e");
    }
    _isAuthenticating = false;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      final biometrics = await _localAuth.getAvailableBiometrics();
      debugPrint("[Biometric] Available types: $biometrics");
      return biometrics;
    } catch (e) {
      debugPrint("[Biometric] getAvailableBiometrics error: $e");
      return [];
    }
  }

  Future<bool> authenticate({
    required BiometricAuthType type,
    String cancelButtonText = 'Cancel',
    String? biometricHint,
    String? biometricRequiredTitle,
    String? signInTitle,
  }) async {
    if (_isAuthenticating) {
      debugPrint("[Biometric] Already authenticating, skipping...");
      return false;
    }
    _isAuthenticating = true;

    String reason;
    switch (type) {
      case BiometricAuthType.login:
        reason = 'Please authenticate to access your account';
        break;
      case BiometricAuthType.transaction:
        reason = 'Please authenticate to authorize this transaction';
        break;
      case BiometricAuthType.setup:
        reason = 'Please authenticate to enable biometric access';
        break;
    }

    debugPrint("[Biometric] Starting auth: $reason");

    try {
      final result = await _localAuth.authenticate(
        localizedReason: reason,
        authMessages: [
          AndroidAuthMessages(
            // biometricHint: biometricHint ?? 'Verify your identity',
            // biometricRequiredTitle:
            //     biometricRequiredTitle ?? 'Authentication Required',
            signInTitle: signInTitle ?? 'Authorize',
            cancelButton: cancelButtonText,
          ),
          IOSAuthMessages(
            cancelButton: cancelButtonText,
            localizedFallbackTitle: 'Use Passcode',
          ),
        ],
        // options: const AuthenticationOptions(
        //   stickyAuth: true,
        //   biometricOnly: true,
        //   useErrorDialogs: true,
        // ),
      );

      debugPrint("[Biometric] Auth result = $result");
      return result;
    } catch (e) {
      debugPrint("[Biometric] Auth error: $e");
      return false;
    } finally {
      _isAuthenticating = false;
    }
  }

  Future<bool> get isBiometricLoginEnabled async {
    final enabled = await _ref
        .read(secureStorageHelperProvider)
        .isBiometricLoginEnabled();
    debugPrint("[Biometric] Login enabled = $enabled");
    return enabled;
  }

  Future<bool> get isBiometricTransactionEnabled async {
    final enabled = await _ref
        .read(secureStorageHelperProvider)
        .isBiometricTransactionEnabled();
    debugPrint("[Biometric] Transaction enabled = $enabled");
    return enabled;
  }

  Future<void> enableBiometricLogin() async {
    debugPrint("[Biometric] Enabling biometric login");
    await _ref.read(secureStorageHelperProvider).setBiometricLoginEnabled(true);
  }

  Future<void> enableBiometricTransaction() async {
    debugPrint("[Biometric] Enabling biometric transaction");
    await _ref
        .read(secureStorageHelperProvider)
        .setBiometricTransactionEnabled(true);
  }

  Future<void> disableBiometricLogin() async {
    debugPrint("[Biometric] Disabling biometric login + clearing creds");
    await _ref
        .read(secureStorageHelperProvider)
        .setBiometricLoginEnabled(false);
    await _ref.read(secureStorageHelperProvider).clearBiometricCredentials();
  }

  Future<void> disableBiometricTransaction() async {
    debugPrint("[Biometric] Disabling biometric transaction");
    await _ref
        .read(secureStorageHelperProvider)
        .setBiometricTransactionEnabled(false);
  }

  Future<void> storeBiometricCredentials({
    required String email,
    required String password,
    String? displayName,
  }) async {
    debugPrint(
      "[Biometric] Storing credentials for $email, displayName=$displayName",
    );
    await _ref
        .read(secureStorageHelperProvider)
        .storeBiometricCredentials(
          email: email,
          password: password,
          displayName: displayName,
        );
  }

  Future<String?> getBiometricEmail() async {
    final email = await _ref
        .read(secureStorageHelperProvider)
        .getBiometricEmail();
    debugPrint("[Biometric] Stored email = $email");
    return email;
  }

  Future<String?> getBiometricPassword() async {
    final pass = await _ref
        .read(secureStorageHelperProvider)
        .getBiometricPassword();
    debugPrint("[Biometric] Stored password = ${pass != null ? '***' : null}");
    return pass;
  }

  Future<String?> getBiometricDisplayName() async {
    final name = await _ref
        .read(secureStorageHelperProvider)
        .getBiometricDisplayName();
    debugPrint("[Biometric] Stored displayName = $name");
    return name;
  }

  Future<bool> hasBiometricCredentials() async {
    final has = await _ref
        .read(secureStorageHelperProvider)
        .hasBiometricCredentials();
    debugPrint("[Biometric] Has stored credentials = $has");
    return has;
  }

  Future<void> clearBiometricData() async {
    debugPrint("[Biometric] Clearing all biometric data + disabling");
    await _ref.read(secureStorageHelperProvider).clearBiometricCredentials();
    await disableBiometricLogin();
    await disableBiometricTransaction();
  }
}
