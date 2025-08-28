import 'package:bundlegram/core/config/constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late final SecureStorageHelper _storage;
  @override
  void initState() {
    super.initState();
    _storage = ref.read(secureStorageHelperProvider);
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await clearIfAppUpdated(); // Step 1: version check
    await Future.delayed(const Duration(seconds: 2)); // Optional splash delay
    _goToWalkThrough(); // Step 2: navigate
  }

  Future<bool> clearIfAppUpdated() async {
    final currentVersionCode = int.tryParse(AppConstants.appBuildNumber) ?? 0;
    final storedVersion = await _storage.getAppVersionCode();

    if (storedVersion == null || storedVersion < currentVersionCode) {
      await _storage.clearAll();
      await _storage.setAppVersionCode(currentVersionCode);
      return true; // Was updated
    }

    return false; // No update
  }

  // Future<void> _checkAndResetOnUpdate() async {
  //   final storedVersionCodeStr = await _storage.read('app_version_code');
  //   final storedVersionCode = int.tryParse(storedVersionCodeStr ?? '0');

  //   if (storedVersionCode == null ||
  //       storedVersionCode < AppVersion.versionCode) {
  //     await _storage.clearAll();
  //     await _storage.write(
  //         'app_version_code', AppVersion.versionCode.toString());
  //   }
  // }

  void _goToWalkThrough() {
    context.go(RouteConstants.walkThrough);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: AppSvgIcon(
          width: 150,
          height: 150,
          path: Assets.svgs.bundlegramWhiteLogo,
          color: AppColors.background,
        ),
      ),
    );
  }
}
