import 'package:bundlegram/presentation/features/biometric/providers/biometric_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final securityProvider = ChangeNotifierProvider((ref) => SecurityNotifier(ref));

class SecurityNotifier extends ChangeNotifier {
  bool _useFaceId = false;
  bool _useFingerprint = false;
  bool _useFingerprintForPayment = false;
  bool _isBiometricAvailable = false;
  List<BiometricType> _availableBiometrics = [];

  final Ref ref;

  SecurityNotifier(this.ref) {
    init();
  }

  bool get useFaceId => _useFaceId;
  bool get useFingerprint => _useFingerprint;
  bool get useFingerprintForPayment => _useFingerprintForPayment;
  bool get isBiometricAvailable => _isBiometricAvailable;
  List<BiometricType> get availableBiometrics => _availableBiometrics;

  set useFaceId(bool value) {
    _useFaceId = value;
    _useFingerprint = value; // Synchronize Face ID and Fingerprint
    notifyListeners();
  }

  set useFingerprint(bool value) {
    _useFingerprint = value;
    _useFaceId = value; // Synchronize Fingerprint and Face ID
    notifyListeners();
  }

  set useFingerprintForPayment(bool value) {
    _useFingerprintForPayment = value;
    notifyListeners();
  }

  Future<void> init() async {
    final biometricService = ref.read(biometricServiceProvider);
    _isBiometricAvailable = await biometricService.isAvailable();
    _availableBiometrics = await biometricService.getAvailableBiometrics();
    _useFaceId = await biometricService.isBiometricLoginEnabled;
    _useFingerprint = await biometricService.isBiometricLoginEnabled;
    _useFingerprintForPayment =
        await biometricService.isBiometricTransactionEnabled;
    notifyListeners();
  }
}
