import 'dart:async';

import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/onboard_notifier.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/onboarding_data.dart';
import 'package:bundlegram/gen/assets.gen.dart';
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
    final storage = ref.read(secureStorageHelperProvider)
      ..setHasSeenPromoModal(false);
    _checkAndRequestPermissions();
  }

  Future<void> _checkAndRequestPermissions() async {
    final locationStatus = await Permission.location.request();

    if (locationStatus.isPermanentlyDenied) {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Location permission is permanently denied. Please enable it manually in the app settings.',
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
                onTap: () async {
                  final storage = ref.read(secureStorageHelperProvider);
                  final rememberedEmail = await storage.getRememberedEmail();

                  if (rememberedEmail != null) {
                    // Go to lock screen if email exists
                    unawaited(context.push(RouteConstants.lockScreen));
                  } else {
                    // Otherwise go to login
                    unawaited(context.push(RouteConstants.login));
                  }
                },
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
