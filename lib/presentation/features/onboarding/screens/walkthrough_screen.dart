import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/onboard_notifier.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/onboarding_data.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class WalkthroughScreen extends ConsumerStatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  ConsumerState<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends ConsumerState<WalkthroughScreen> {
  @override
  void initState() {
    super.initState();
    _checkAndRequestPermissions();
  }

  Future<bool> _checkAndRequestPermissions() async {
    // First check current permission status
    PermissionStatus locationStatus = await Permission.location.status;

    debugPrint('Initial location permission status: $locationStatus');

    // If already granted, return success
    if (locationStatus.isGranted) {
      debugPrint('Location permission already granted');
      return true;
    }

    // If restricted (iOS parental controls), can't proceed
    if (locationStatus.isRestricted) {
      debugPrint('Location permission is restricted');
      _showRestrictedDialog();
      return false;
    }

    // If permanently denied, direct to settings
    if (locationStatus.isPermanentlyDenied) {
      debugPrint('Location permission permanently denied');
      _showPermissionDialog();
      return false;
    }

    // If denied or not determined, request permission
    if (locationStatus.isDenied) {
      debugPrint('Requesting location permission...');
      locationStatus = await Permission.location.request();

      // Handle the response
      switch (locationStatus) {
        case PermissionStatus.granted:
          debugPrint('Location permission granted');
          return true;

        case PermissionStatus.denied:
          debugPrint('Location permission denied by user');
          _showDeniedDialog();
          return false;

        case PermissionStatus.permanentlyDenied:
          debugPrint('Location permission permanently denied');
          _showPermissionDialog();
          return false;

        case PermissionStatus.restricted:
          debugPrint('Location permission restricted');
          _showRestrictedDialog();
          return false;

        default:
          debugPrint('Unknown permission status: $locationStatus');
          return false;
      }
    }

    return false;
  }

  void _showDeniedDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Location Access'),
        content: const Text(
          'Location permission is needed to provide location-based features. You can grant permission later in app settings if needed.',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              // Try requesting one more time
              _retryPermissionRequest();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Location permission is permanently denied. Please enable it manually in the app settings to use location features.',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showRestrictedDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Location Restricted'),
        content: const Text(
          'Location access is restricted on this device. This may be due to parental controls or device management policies.',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _retryPermissionRequest() async {
    final status = await Permission.location.status;

    if (status.isDenied) {
      final newStatus = await Permission.location.request();
      if (newStatus.isPermanentlyDenied) {
        _showPermissionDialog();
      } else if (newStatus.isGranted) {
        debugPrint('Location permission granted on retry');
        // Continue with location functionality
        _onLocationPermissionGranted();
      }
    } else if (status.isPermanentlyDenied) {
      _showPermissionDialog();
    }
  }

  void _onLocationPermissionGranted() {
    // Add your location-dependent functionality here
    debugPrint('Location permission granted - starting location services');
    // Example: Start location tracking, show location-based content, etc.
  }

// Alternative comprehensive approach with rationale
  Future<bool> requestLocationPermissionWithRationale() async {
    // Check if we should show rationale (good UX practice)
    final status = await Permission.location.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      // Show rationale dialog first
      final shouldRequest = await _showRationaleDialog();
      if (!shouldRequest) return false;
    }

    if (status.isPermanentlyDenied) {
      _showPermissionDialog();
      return false;
    }

    if (status.isRestricted) {
      _showRestrictedDialog();
      return false;
    }

    // Request permission
    final result = await Permission.location.request();

    if (result.isGranted) {
      _onLocationPermissionGranted();
      return true;
    } else if (result.isPermanentlyDenied) {
      _showPermissionDialog();
      return false;
    }

    return false;
  }

  Future<bool> _showRationaleDialog() async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: const Text('Location Permission'),
            content: const Text(
              'This app needs location access to provide you with personalized, location-based features and services.',
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Not Now'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Allow'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(onboardingNotifierProvider.notifier);
    final walkthroughIndex = ref.watch(
      onboardingNotifierProvider.select((v) => v.walkThroughIndex),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              50.verticalSpace,
              Expanded(
                child: PageView(
                  onPageChanged: notifier.updateWalkThroughIndex,
                  children:
                      List.generate(OnboardingData.walkthrough.length, (index) {
                    return Column(
                      children: [
                        Text(
                          OnboardingData.walkthrough[index]['name']!
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleLarge,
                        ),
                        14.verticalSpace,
                        Text(
                          OnboardingData.walkthrough[index]['subText']!,
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodySmall,
                        ),
                        Expanded(
                          child: Center(
                            child: AssetGenImage(
                              OnboardingData.walkthrough[index]['icon']!,
                            ).image(),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 6.h),
                    width: walkthroughIndex == index ? 20.w : 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: index == walkthroughIndex
                          ? Colors.black
                          : const Color(0xffB3B3B3),
                    ),
                  );
                }),
              ),
              30.verticalSpace,
              BundlegramButton(
                text: 'Create account',
                onPressed: () => context.go(RouteConstants.register),
              ),
              25.verticalSpace,
              InkWell(
                onTap: () => context.push(RouteConstants.login),
                child: Text(
                  'I already have an account',
                  style: context.textTheme.bodyMedium,
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
