// New file: biometric_service.dart
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

enum BiometricAuthType {
  login,
  transaction,
  setup,
}

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
      return isAvailable || isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  Future<void> stopAuthentication() async {
    try {
      await _localAuth.stopAuthentication();
    } catch (e) {}
    _isAuthenticating = false;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
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
    try {
      final result = await _localAuth.authenticate(
        localizedReason: reason,
        authMessages: [
          AndroidAuthMessages(
            biometricHint: biometricHint ?? 'Verify your identity',
            biometricRequiredTitle:
                biometricRequiredTitle ?? 'Authentication Required',
            signInTitle: signInTitle ?? 'Authorize',
            cancelButton: cancelButtonText,
          ),
          IOSAuthMessages(
            cancelButton: cancelButtonText,
            localizedFallbackTitle: 'Use Passcode',
          ),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      return result;
    } catch (e) {
      return false;
    } finally {
      _isAuthenticating = false;
    }
  }

  Future<bool> get isBiometricLoginEnabled async {
    return await _ref
        .read(secureStorageHelperProvider)
        .isBiometricLoginEnabled();
  }

  Future<bool> get isBiometricTransactionEnabled async {
    return await _ref
        .read(secureStorageHelperProvider)
        .isBiometricTransactionEnabled();
  }

  Future<void> enableBiometricLogin() async {
    await _ref.read(secureStorageHelperProvider).setBiometricLoginEnabled(true);
  }

  Future<void> enableBiometricTransaction() async {
    await _ref
        .read(secureStorageHelperProvider)
        .setBiometricTransactionEnabled(true);
  }

  Future<void> disableBiometricLogin() async {
    await _ref
        .read(secureStorageHelperProvider)
        .setBiometricLoginEnabled(false);
    await _ref.read(secureStorageHelperProvider).clearBiometricCredentials();
  }

  Future<void> disableBiometricTransaction() async {
    await _ref
        .read(secureStorageHelperProvider)
        .setBiometricTransactionEnabled(false);
  }

  Future<void> storeBiometricCredentials({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await _ref.read(secureStorageHelperProvider).storeBiometricCredentials(
          email: email,
          password: password,
          displayName: displayName,
        );
  }

  Future<String?> getBiometricEmail() async {
    return await _ref.read(secureStorageHelperProvider).getBiometricEmail();
  }

  Future<String?> getBiometricPassword() async {
    return await _ref.read(secureStorageHelperProvider).getBiometricPassword();
  }

  Future<String?> getBiometricDisplayName() async {
    return await _ref
        .read(secureStorageHelperProvider)
        .getBiometricDisplayName();
  }

  Future<bool> hasBiometricCredentials() async {
    return await _ref
        .read(secureStorageHelperProvider)
        .hasBiometricCredentials();
  }

  Future<void> clearBiometricData() async {
    await _ref.read(secureStorageHelperProvider).clearBiometricCredentials();
    await disableBiometricLogin();
    await disableBiometricTransaction();
  }
}
