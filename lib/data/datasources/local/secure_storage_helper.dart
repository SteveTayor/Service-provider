import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_helper.g.dart';

class SecureStorageHelper {
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'auth_token';

  SecureStorageHelper(this._storage);

  Future<String?> getAuthToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> setAuthToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: _tokenKey);
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