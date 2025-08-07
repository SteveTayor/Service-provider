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

  SecureStorageHelper(this._storage);

  Future<String?> getAuthToken() async {
    return await _storage.read(key: _tokenKey);
  }
  Future<void> setAppVersionCode(int versionCode) async {
    await _storage.write(
      key: _appVersionCodeKey,
      value: versionCode.toString(),
    );
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

  Future<void> setPassword(String password) async {
    await _storage.write(key: _password, value: password);
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
}

@Riverpod(keepAlive: true)
SecureStorageHelper secureStorageHelper(SecureStorageHelperRef ref) {
  const storage = FlutterSecureStorage();
  return SecureStorageHelper(storage);
}
