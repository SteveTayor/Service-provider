import 'dart:convert';
import 'dart:io';

import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Provider for app actions
final appActionsProvider = Provider<AppActionsNotifier>((ref) {
  return AppActionsNotifier();
});

class AppActionsNotifier {
  static const String _androidPackageName = 'com.verygoodcore.bundlegram';
  static const String _iosAppId = '123456789'; // <-- Replace with real iOS ID
  static const String _appShareMessage =
      'Check out Bundlegram - the best app for getting your cheap airtime and data bundles! Download it now:';

  Future<void> rateApp(BuildContext context) async {
    try {
      final String url = Platform.isAndroid
          ? 'market://details?id=$_androidPackageName'
          : 'itms-apps://itunes.apple.com/app/id$_iosAppId?action=write-review';

      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await _launchWebFallback(context);
      }
    } catch (_) {
      context.showErrorSnackBar('Unable to open app store');
    }
  }

  Future<void> shareApp(BuildContext context) async {
    final String storeUrl = Platform.isAndroid
        ? 'https://play.google.com/store/apps/details?id=$_androidPackageName'
        : 'https://apps.apple.com/app/id$_iosAppId';

    final String shareText = '$_appShareMessage\n$storeUrl';

    await SharePlus.instance.share(
      ShareParams(
        text: shareText,
        subject: 'Download Bundlegram',
        title: 'Share Bundlegram App',
      ),
    );
  }

// ============================================================
  // UPDATE CHECK FUNCTIONS
  // ============================================================

  /// Check for updates with UI feedback (for settings "Update app" button)
  Future<void> checkForUpdate(BuildContext context) async {
    if (Platform.isAndroid) {
      await _checkAndroidInAppUpdate(context);
    } else {
      await _checkIOSUpdate(context);
    }
  }

  /// Check for updates silently (for dashboard - no UI unless update available)
  Future<void> checkForUpdateSilently(BuildContext context) async {
    try {
      final updateInfo = await checkForUpdateInfo();
      if (updateInfo != null && updateInfo['hasUpdate'] == true) {
        _showUpdateDialog(
          context,
          updateInfo['currentVersion']! as String,
          updateInfo['latestVersion']! as String,
        );
      }
    } catch (_) {
      // Fail silently for background checks
    }
  }

  /// Get update info without UI (returns map with update status)
  Future<Map<String, dynamic>?> checkForUpdateInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      String? latestVersion;

      if (Platform.isAndroid) {
        latestVersion = await _getLatestAndroidVersion();
      } else if (Platform.isIOS) {
        latestVersion = await _getLatestIOSVersion();
      }

      if (latestVersion != null &&
          _isUpdateAvailable(currentVersion, latestVersion)) {
        return {
          'hasUpdate': true,
          'currentVersion': currentVersion,
          'latestVersion': latestVersion,
        };
      }

      return {'hasUpdate': false};
    } catch (_) {
      return null;
    }
  }

  /// Android In-App Update using Google Play Core API
  Future<void> _checkAndroidInAppUpdate(BuildContext context) async {
    try {
      // Show loading
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                ),
                SizedBox(width: 16),
                Text('Checking for updates...'),
              ],
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }

      final updateInfo = await InAppUpdate.checkForUpdate();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

// Debug logging to understand Play Core result
      if (kDebugMode) {
        debugPrint(
            'InAppUpdate updateAvailability: ${updateInfo.updateAvailability}');
        debugPrint('Immediate allowed: ${updateInfo.immediateUpdateAllowed}');
        debugPrint('Flexible allowed: ${updateInfo.flexibleUpdateAllowed}');
        debugPrint(
            'Available version code: ${updateInfo.availableVersionCode}');
      }

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        // Show dialog asking user if they want to update
        _showInAppUpdateDialog(context, updateInfo);
      } else {
        context.showSuccessSnackBar('No updates available');
      }
    } catch (e, st) {
      debugPrint('Error checking for in-app update: $e\n$st');
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        context.showErrorSnackBar('Unable to check for updates');
      }
    }
  }

  void _showInAppUpdateDialog(BuildContext context, AppUpdateInfo updateInfo) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Update Available'),
        content: const Text(
          'A new version of Bundlegram is available! Would you like to update now?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Later',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
          BundlegramButton(
            onPressed: () {
              Navigator.pop(context);
              _performInAppUpdate(context, updateInfo);
            },
            text: 'Update Now',
          ),
        ],
      ),
    );
  }

  Future<void> _performInAppUpdate(
    BuildContext context,
    AppUpdateInfo updateInfo,
  ) async {
    try {
      if (updateInfo.immediateUpdateAllowed) {
        // Immediate update - blocks the app until update completes
        await InAppUpdate.performImmediateUpdate();
      } else if (updateInfo.flexibleUpdateAllowed) {
        // Flexible update - downloads in background
        await InAppUpdate.startFlexibleUpdate();

        // Listen to update state
        InAppUpdate.completeFlexibleUpdate().then((_) {
          if (context.mounted) {
            context.showSuccessSnackBar('Update completed successfully!');
          }
        });
      } else {
        // Fallback to Play Store
        _redirectToStore(context);
      }
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar('Update failed. Please try again.');
      }
    }
  }

  /// iOS update check (opens App Store)
  Future<void> _checkIOSUpdate(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              ),
              SizedBox(width: 16),
              Text('Checking for updates...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final latestVersion = await _getLatestIOSVersion();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (latestVersion == null) {
        context.showErrorSnackBar('Unable to check for updates');
        return;
      }

      if (_isUpdateAvailable(currentVersion, latestVersion)) {
        _showUpdateDialog(context, currentVersion, latestVersion);
      } else {
        context.showSuccessSnackBar('No updates available');
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        context.showErrorSnackBar('Error checking for updates');
      }
    }
  }

  /// Initiate in-app update (for update banner)
  Future<void> initiateInAppUpdate(BuildContext context) async {
    if (Platform.isAndroid) {
      try {
        final updateInfo = await InAppUpdate.checkForUpdate();
        if (updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          await _performInAppUpdate(context, updateInfo);
        } else {
          _redirectToStore(context);
        }
      } catch (_) {
        _redirectToStore(context);
      }
    } else {
      _redirectToStore(context);
    }
  }

  Future<String?> _getLatestAndroidVersion() async {
    try {
      final url =
          'https://play.google.com/store/apps/details?id=$_androidPackageName&hl=en';
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final body = response.body.replaceAll('\n', '');
        final match = RegExp(r'Current Version.+?>([\d.]+)<').firstMatch(body);
        return match?.group(1);
      }
    } catch (_) {}
    return null;
  }

  Future<String?> _getLatestIOSVersion() async {
    try {
      final url = 'https://itunes.apple.com/lookup?id=$_iosAppId';
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List?;
        if (results != null && results.isNotEmpty) {
          return results[0]['version'] as String?;
        }
      }
    } catch (_) {}
    return null;
  }

  bool _isUpdateAvailable(String current, String latest) {
    final currentParts = current.split('.').map(int.parse).toList();
    final latestParts = latest.split('.').map(int.parse).toList();
    while (currentParts.length < latestParts.length) currentParts.add(0);
    while (latestParts.length < currentParts.length) latestParts.add(0);

    for (int i = 0; i < currentParts.length; i++) {
      if (latestParts[i] > currentParts[i]) return true;
      if (latestParts[i] < currentParts[i]) return false;
    }
    return false;
  }

  void _showUpdateDialog(BuildContext context, String current, String latest) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Update Available'),
        content: Text(
            'A new version of Bundlegram is available!\n\nCurrent: $current\nLatest: $latest'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              'Later',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.mabryPro,
              ),
            ),
          ),
          BundlegramButton(
            onPressed: () {
              context.pop();
              _redirectToStore(context);
            },
            text: 'Update',
            cornerRadius: 8,
            buttonStyle: BundlegramButtonStyle.primary(),
          ),
        ],
      ),
    );
  }

  Future<void> _redirectToStore(BuildContext context) async {
    final url = Platform.isAndroid
        ? 'market://details?id=$_androidPackageName'
        : 'itms-apps://itunes.apple.com/app/id$_iosAppId';

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await _launchWebFallback(context);
    }
  }

  Future<void> _launchWebFallback(BuildContext context) async {
    final url = Platform.isAndroid
        ? 'https://play.google.com/store/apps/details?id=$_androidPackageName'
        : 'https://apps.apple.com/app/id=$_iosAppId';

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      context.showErrorSnackBar('Unable to open browser');
    }
  }

  void goToPromo(BuildContext context) {
    context.push(RouteConstants.promo);
  }

  // void _showErrorSnackBar(BuildContext context, String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message), backgroundColor: Colors.red),
  //   );
  // }

  // void _showSuccessSnackBar(BuildContext context, String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message), backgroundColor: Colors.green),
  //   );
  // }

  void _showLoadingSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
