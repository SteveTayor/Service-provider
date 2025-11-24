import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';

extension BiometricSafeHelpers on SecureStorageHelper {
  Future<String?> getSafeEmail() async {
    // Small delay avoids race conditions with FlutterSecureStorage reads
    await Future.delayed(const Duration(milliseconds: 150));

    // 1. Biometric email
    final bioEmail = await getBiometricEmail();
    if (bioEmail != null && bioEmail.isNotEmpty) return bioEmail;

    // 2. Remembered email
    final remembered = await getRememberedEmail();
    if (remembered != null && remembered.isNotEmpty) return remembered;

    // 3. Username (fallback)
    final username = await getUsername();
    if (username != null && username.isNotEmpty) return username;

    return null;
  }
}
