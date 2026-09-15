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

      final lastVersion = await _storage.getLastVersionName();
      final lastBuildNumber = await _storage.getAppVersionCode();

      // FIX: `lastVersion == null`
      if (lastVersion == null || lastBuildNumber == null) {
        debugPrint(
          'No previous version recorded — could be a fresh install, or an '
          'update from a build that predates version tracking. Clearing '
          'stale data defensively either way.',
        );
        await _clearStaleData();
        await _storage.setMigrationPendingInvalidation(true);
        await _saveCurrentVersion(currentVersion, currentBuildNumber);
        return true;
      }

      // Check if version changed
      if (lastVersion != currentVersion ||
          lastBuildNumber != currentBuildNumber) {
        debugPrint(
          'App updated from $lastVersion ($lastBuildNumber) to $currentVersion ($currentBuildNumber)',
        );

        await _clearStaleData();

        // flag GlobalProvider to invalidate Riverpod caches on the first
        // boot after this update. Uses consume pattern so it fires
        // exactly once.
        await _storage.setMigrationPendingInvalidation(true);

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
      final all = await _storage.readAll();

      const preserve = {
        'auth_token',
        'remembered_email',
        'sign_in_password',
        'cached_username',
        'biometric_email',
        'biometric_password',
        'biometric_display_name',
        'biometric_login_enabled',
        'biometric_transaction_enabled',
        'fcm_token',
        'mac_address',
        'ip_address',
        'latitude',
        'longitude',
        'platform',
        'last_version_name',
        'app_version_code',
        'migration_pending_invalidation',
        'app_theme_mode',
        'has_seen_promo_modal',
      };

      int deleted = 0;
      for (final key in all.keys) {
        if (key.endsWith('_pin')) continue;
        if (preserve.contains(key)) continue;

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
