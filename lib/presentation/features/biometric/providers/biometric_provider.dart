import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'biometric_service.dart';

final biometricSetupProvider = Provider((ref) => BiometricSetupProvider(ref));

class BiometricSetupProvider {
  final Ref ref;

  BiometricSetupProvider(this.ref);

  Future<void> setupBiometricWithCredentials({
    required BuildContext context,
    required String email,
    required String password,
    String? displayName,
  }) async {
    final biometricService = ref.read(biometricServiceProvider);
    final secureStorage = ref.read(secureStorageHelperProvider);

    final bool isAvailable = await biometricService.isAvailable();
    if (!isAvailable) {
      context.showErrorSnackBar(
          'Biometric authentication is not available on this device');
      return;
    }

    final availableBiometrics = await biometricService.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      context.showErrorSnackBar(
          'No biometric authentication methods are enrolled on this device');
      return;
    }

    final hasPin = await secureStorage.getPin(email) != null;
    if (!hasPin) {
      context.showErrorSnackBar('Please set your transaction PIN first');
      return;
    }

    final authenticated =
        await biometricService.authenticate(type: BiometricAuthType.setup);
    if (authenticated) {
      await biometricService.storeBiometricCredentials(
        email: email,
        password: password,
        displayName: displayName,
      );
      await biometricService.enableBiometricLogin();
      context
          .showSuccessSnackBar('Biometric authentication enabled successfully');
    } else {
      context.showErrorSnackBar('Biometric authentication failed');
    }
  }
}
