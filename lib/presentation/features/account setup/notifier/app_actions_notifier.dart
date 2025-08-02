import 'dart:convert';
import 'dart:io';

import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
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

  Future<void> checkForUpdate(BuildContext context) async {
    try {
      _showLoadingSnackBar(context, 'Checking for updates...');
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      String? latestVersion;

      if (Platform.isAndroid) {
        latestVersion = await _getLatestAndroidVersion();
      } else if (Platform.isIOS) {
        latestVersion = await _getLatestIOSVersion();
      }

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (latestVersion == null) {
        context.showErrorSnackBar('Unable to check for updates');
        return;
      }

      if (_isUpdateAvailable(currentVersion, latestVersion)) {
        _showUpdateDialog(context, currentVersion, latestVersion);
      } else {
        context.showSuccessSnackBar('You have the latest version!');
      }
    } catch (_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      context.showErrorSnackBar('Error checking for updates');
    }
  }

  Future<String?> _getLatestAndroidVersion() async {
    try {
      final url =
          'https://play.google.com/store/apps/details?id=$_androidPackageName&hl=en';
      final response = await http.get(Uri.parse(url));
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
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'];
        // if (results.isNotEmpty) {
        //   return results[0]['version'];
        // }
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
              ),
            ),
          ),
          BundlegramButton(
            onPressed: () {
              Navigator.pop(context);
              _redirectToStore(context);
            },
            text: 'Update',
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
