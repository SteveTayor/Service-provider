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
          'First app launch - version saved: $currentVersion ($currentBuildNumber)',
        );
        return false;
      }

      // Check if version changed
      if (lastVersion != currentVersion ||
          lastBuildNumber != currentBuildNumber) {
        debugPrint(
          'App updated from $lastVersion ($lastBuildNumber) to $currentVersion ($currentBuildNumber)',
        );

        // Clear stale data but preserve important user data
        await _clearStaleData();

        //  flag GlobalProvider to invalidate Riverpod caches
        // on the first boot after this update. Uses consume pattern so it
        // fires exactly once.
        await _storage.setMigrationPendingInvalidation(true);

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
      // Read all keys currently in storage
      final all = await _storage.readAll();

      // These keys must never be deleted — user would be logged out
      // or lose critical settings if they were removed.
      const preserve = {
        // Auth
        'auth_token',

        // Login credentials
        'remembered_email',
        'sign_in_password',
        'cached_username',

        // PIN (keyed as '{email}_pin' — matched by prefix below)
        // handled separately via startsWith check

        // Biometric
        'biometric_email',
        'biometric_password',
        'biometric_display_name',
        'biometric_login_enabled',
        'biometric_transaction_enabled',

        // FCM — losing this means no push notifications until next token refresh
        'fcm_token',

        // Device info — needed for transaction requests
        'mac_address',
        'ip_address',
        'latitude',
        'longitude',
        'platform',

        // Version tracking — must survive or we loop forever
        'last_version_name',
        'app_version_code',

        // Migration flag we just wrote — must not delete it here
        'migration_pending_invalidation',

        // User preferences
        'app_theme_mode',
        'has_seen_promo_modal',
      };

      int deleted = 0;
      for (final key in all.keys) {
        // Preserve PIN keys — stored as '{email}_pin'
        if (key.endsWith('_pin')) continue;

        // Preserve anything in the explicit set
        if (preserve.contains(key)) continue;

        //Everything else is refetchable — delete it
        await _storage.delete(key);
        deleted++;
        debugPrint('[VersionManager] deleted stale key: $key');
      }

      debugPrint(
        '[VersionManager] _clearStaleData: deleted $deleted keys, '
        'preserved ${all.length - deleted}',
      );
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
  // Future<void> clearAllData() async {
  //   await _storage.clearAll();
  //   debugPrint('All app data cleared');
  // }

  /// Check if this is the first launch after install
  Future<bool> isFirstLaunch() async {
    final versionCode = await _storage.getAppVersionCode();
    return versionCode == null;
  }
}

@Riverpod(keepAlive: true)
VersionManager versionManager(Ref ref) {
  final storage = ref.watch(secureStorageHelperProvider);
  return VersionManager(storage);
}
