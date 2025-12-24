import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'version_manager.g.dart';

class VersionManager {
  final SecureStorageHelper _storage;

  VersionManager(this._storage);

  /// Check if app was updated and clear stale data if needed
  Future<bool> checkAndHandleAppUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      final currentVersion = packageInfo.version;
      final currentBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

      // Get last known version info
      final lastVersion = await _storage.getLastVersionName();
      final lastBuildNumber = await _storage.getAppVersionCode();

      // First time app is opened
      if (lastVersion == null || lastBuildNumber == null) {
        await _saveCurrentVersion(currentVersion, currentBuildNumber);
        debugPrint(
            'First app launch - version saved: $currentVersion ($currentBuildNumber)');
        return false;
      }

      // Check if version changed
      if (lastVersion != currentVersion ||
          lastBuildNumber != currentBuildNumber) {
        debugPrint(
            'App updated from $lastVersion ($lastBuildNumber) to $currentVersion ($currentBuildNumber)');

        // Clear stale data but preserve important user data
        await _clearStaleData();

        // Save new version
        await _saveCurrentVersion(currentVersion, currentBuildNumber);

        return true; // App was updated
      }

      return false; // No update
    } catch (e, st) {
      debugPrint('Error checking app version: $e\n$st');
      return false;
    }
  }

  /// Clear stale data while preserving critical user data
  Future<void> _clearStaleData() async {
    try {
      // Get current critical data before clearing
      final authToken = await _storage.getAuthToken();
      final username = await _storage.getUsername();
      final rememberedEmail = await _storage.getRememberedEmail();
      final password = await _storage.getPassword();
      final fcmToken = await _storage.getFcmToken();

      // Biometric data
      final biometricEmail = await _storage.getBiometricEmail();
      final biometricPassword = await _storage.getBiometricPassword();
      final biometricDisplayName = await _storage.getBiometricDisplayName();
      final biometricLoginEnabled = await _storage.isBiometricLoginEnabled();
      final biometricTransactionEnabled =
          await _storage.isBiometricTransactionEnabled();

      // Device info
      final deviceInfo = await _storage.getDeviceInfo();

      // Version info
      final versionCode = await _storage.getAppVersionCode();

      // Clear everything
      await _storage.clearAll();

      // Restore critical data
      if (authToken != null) await _storage.setAuthToken(authToken);
      if (username != null) await _storage.setUsername(username);
      if (rememberedEmail != null)
        await _storage.setRememberedEmail(rememberedEmail);
      if (password != null) await _storage.setPassword(password);
      if (fcmToken != null) await _storage.saveFcmToken(fcmToken);

      // Restore biometric data
      if (biometricEmail != null && biometricPassword != null) {
        await _storage.storeBiometricCredentials(
          email: biometricEmail,
          password: biometricPassword,
          displayName: biometricDisplayName,
        );
      }
      if (biometricLoginEnabled) {
        await _storage.setBiometricLoginEnabled(true);
      }
      if (biometricTransactionEnabled) {
        await _storage.setBiometricTransactionEnabled(true);
      }

      // Restore device info
      if (deviceInfo['macAddress'] != 'unknown') {
        await _storage.setDeviceInfo(
          macAddress: deviceInfo['macAddress']!,
          ipAddress: deviceInfo['ipAddress']!,
          latitude: deviceInfo['latitude']!,
          longitude: deviceInfo['longitude']!,
          platform: deviceInfo['platform']!,
        );
      }

      // Restore version code
      if (versionCode != null) {
        await _storage.setAppVersionCode(versionCode);
      }

      debugPrint(
          'Cleared stale data after app update - preserved critical user data');
    } catch (e, st) {
      debugPrint('Error clearing stale data: $e\n$st');
    }
  }

  Future<void> _saveCurrentVersion(String version, int buildNumber) async {
    try {
      await _storage.setLastVersionName(version);
      await _storage.setAppVersionCode(buildNumber);
    } catch (e, st) {
      debugPrint('Error saving version: $e\n$st');
    }
  }

  /// Force clear all app data (use with caution - e.g., on logout)
  Future<void> clearAllData() async {
    await _storage.clearAll();
    debugPrint('All app data cleared');
  }

  /// Check if this is the first launch after install
  Future<bool> isFirstLaunch() async {
    final versionCode = await _storage.getAppVersionCode();
    return versionCode == null;
  }
}

@Riverpod(keepAlive: true)
VersionManager versionManager(VersionManagerRef ref) {
  final storage = ref.watch(secureStorageHelperProvider);
  return VersionManager(storage);
}
