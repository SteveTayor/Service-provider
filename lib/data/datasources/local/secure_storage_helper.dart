import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_helper.g.dart';

class SecureStorageHelper {
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'auth_token';
  static const _rememberedEmailKey = 'remembered_email';
  static const _password = 'sign_in_password';
  static const _macAddressKey = 'mac_address';
  static const _ipAddressKey = 'ip_address';
  static const _latitudeKey = 'latitude';
  static const _longitudeKey = 'longitude';
  static const _platformKey = 'platform';
  static const _appVersionCodeKey = 'app_version_code';
  static const _usernameKey = 'cached_username';
  static const _biometricEmailKey = 'biometric_email';
  static const _biometricPasswordKey = 'biometric_password';
  static const _biometricDisplayNameKey = 'biometric_display_name';
  static const _biometricLoginEnabledKey = 'biometric_login_enabled';
  static const _biometricTransactionEnabledKey =
      'biometric_transaction_enabled';
  static const _fcmTokenKey = 'fcm_token';
  static const _hasSeenPromoKey = 'has_seen_promo_modal';
  static const _lastVersionNameKey = 'last_version_name';
  static const _themeModeKey = 'app_theme_mode';
// ─── Migration invalidation flag ──────────────────────────────────────────
  static const _migrationInvalidationKey = 'migration_pending_invalidation';

  SecureStorageHelper(this._storage);

  Future<void> setMigrationPendingInvalidation(bool value) async {
    await _storage.write(
      key: _migrationInvalidationKey,
      value: value.toString(),
    );
  }

  /// Read-and-delete — returns true exactly once per migration, never again.
  Future<bool> consumeMigrationPendingInvalidation() async {
    final value = await _storage.read(key: _migrationInvalidationKey);
    if (value == 'true') {
      await _storage.delete(key: _migrationInvalidationKey);
      return true;
    }
    return false;
  }

  /// Returns all key-value pairs currently in secure storage.
  /// Used by VersionManager to selectively delete stale keys.
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  /// Deletes a single key from secure storage.
  /// Used by VersionManager for selective cleanup.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> setThemeMode(String mode) async {
    await _storage.write(key: _themeModeKey, value: mode);
  }

  Future<String?> getThemeMode() async {
    return await _storage.read(key: _themeModeKey);
  }

  Future<void> setLastVersionName(String version) async {
    await _storage.write(key: _lastVersionNameKey, value: version);
  }

  Future<String?> getLastVersionName() async {
    return await _storage.read(key: _lastVersionNameKey);
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> setAppVersionCode(int versionCode) async {
    await _storage.write(
      key: _appVersionCodeKey,
      value: versionCode.toString(),
    );
  }

  Future<void> saveBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<bool?> getBool(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    return value.toLowerCase() == 'true';
  }

  Future<int?> getAppVersionCode() async {
    final value = await _storage.read(key: _appVersionCodeKey);
    return int.tryParse(value ?? '');
  }

  Future<void> setAuthToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<void> setUsername(String username) async {
    await _storage.write(key: _usernameKey, value: username);
  }

  Future<String?> getUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  Future<void> clearUsername() async {
    await _storage.delete(key: _usernameKey);
  }

  Future<void> setPassword(String password) async {
    await _storage.write(key: _password, value: password);
  }

  Future<void> setPin(String email, String pin) async {
    await _storage.write(key: '${email}_pin', value: pin);
  }

  Future<String?> getPin(String email) async {
    return await _storage.read(key: '${email}_pin');
  }

  Future<void> clearPin(String email) async {
    await _storage.delete(key: '${email}_pin');
  }

  Future<String?> getPassword() async {
    return await _storage.read(key: _password);
  }

  // Remembered email
  Future<void> setRememberedEmail(String email) async {
    await _storage.write(key: _rememberedEmailKey, value: email);
  }

  Future<void> setDeviceInfo({
    required String macAddress,
    required String ipAddress,
    required String latitude,
    required String longitude,
    required String platform,
  }) async {
    await _storage.write(key: _macAddressKey, value: macAddress);
    await _storage.write(key: _ipAddressKey, value: ipAddress);
    await _storage.write(key: _latitudeKey, value: latitude);
    await _storage.write(key: _longitudeKey, value: longitude);
    await _storage.write(key: _platformKey, value: platform);
  }

  Future<Map<String, String>> getDeviceInfo() async {
    final macAddress = await _storage.read(key: _macAddressKey) ?? 'unknown';
    final ipAddress = await _storage.read(key: _ipAddressKey) ?? '0.0.0.0';
    final latitude = await _storage.read(key: _latitudeKey) ?? '0.0';
    final longitude = await _storage.read(key: _longitudeKey) ?? '0.0';
    final platform = await _storage.read(key: _platformKey) ?? 'unknown';
    return {
      'macAddress': macAddress,
      'ipAddress': ipAddress,
      'latitude': latitude,
      'longitude': longitude,
      'platform': platform,
    };
  }

  Future<void> clearDeviceInfo() async {
    await _storage.delete(key: _macAddressKey);
    await _storage.delete(key: _ipAddressKey);
    await _storage.delete(key: _latitudeKey);
    await _storage.delete(key: _longitudeKey);
    await _storage.delete(key: _platformKey);
  }

  Future<String?> getRememberedEmail() async {
    return await _storage.read(key: _rememberedEmailKey);
  }

  Future<void> clearRememberedEmail() async {
    await _storage.delete(key: _rememberedEmailKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<void> saveFcmToken(String token) async {
    await _storage.write(key: _fcmTokenKey, value: token);
  }

  Future<String?> getFcmToken() async {
    return await _storage.read(key: _fcmTokenKey);
  }

  Future<bool> hasSeenPromoModal() async {
    final value = await _storage.read(key: _hasSeenPromoKey);
    return value == 'true';
  }

  Future<void> setHasSeenPromoModal(bool value) async {
    await _storage.write(key: _hasSeenPromoKey, value: value.toString());
  }

  Future<void> storeBiometricCredentials({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await _storage.write(key: _biometricEmailKey, value: email);
    await _storage.write(key: _biometricPasswordKey, value: password);
    if (displayName != null) {
      await _storage.write(key: _biometricDisplayNameKey, value: displayName);
    }
  }

  Future<String?> getBiometricEmail() async {
    return await _storage.read(key: _biometricEmailKey);
  }

  Future<String?> getBiometricPassword() async {
    return await _storage.read(key: _biometricPasswordKey);
  }

  Future<String?> getBiometricDisplayName() async {
    return await _storage.read(key: _biometricDisplayNameKey);
  }

  Future<bool> hasBiometricCredentials() async {
    final email = await getBiometricEmail();
    final password = await getBiometricPassword();
    return email != null &&
        password != null &&
        email.isNotEmpty &&
        password.isNotEmpty;
  }

  Future<void> clearBiometricCredentials() async {
    await _storage.delete(key: _biometricEmailKey);
    await _storage.delete(key: _biometricPasswordKey);
    await _storage.delete(key: _biometricDisplayNameKey);
  }

  Future<void> setBiometricLoginEnabled(bool value) async {
    await _storage.write(
        key: _biometricLoginEnabledKey, value: value.toString());
  }

  Future<void> setBiometricTransactionEnabled(bool value) async {
    await _storage.write(
        key: _biometricTransactionEnabledKey, value: value.toString());
  }

  Future<bool> isBiometricLoginEnabled() async {
    final value = await _storage.read(key: _biometricLoginEnabledKey);
    return value?.toLowerCase() == 'true';
  }

  Future<bool> isBiometricTransactionEnabled() async {
    final value = await _storage.read(key: _biometricTransactionEnabledKey);
    return value?.toLowerCase() == 'true';
  }
}

@Riverpod(keepAlive: true)
SecureStorageHelper secureStorageHelper(SecureStorageHelperRef ref) {
  const storage = FlutterSecureStorage();
  return SecureStorageHelper(storage);
}
