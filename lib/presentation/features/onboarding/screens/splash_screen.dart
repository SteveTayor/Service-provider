import 'dart:math';

import 'package:bundlegram/core/config/constants.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final SecureStorageHelper _storage;

  // Animation controllers
  late AnimationController _wrapperController;
  late AnimationController _logoController;
  late AnimationController _ribbonController;

  // Animations
  late Animation<double> _wrapperScale;
  late Animation<double> _wrapperOpacity;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _ribbonRotation;
  late Animation<Offset> _ribbonSlide;

  @override
  void initState() {
    super.initState();
    // _storage = ref.read(secureStorageHelperProvider);
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    // Wrapper animation (gift box appearance)
    _wrapperController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Logo reveal animation
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Ribbon animation
    _ribbonController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Wrapper animations
    _wrapperScale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _wrapperController,
      curve: Curves.elasticOut,
    ));

    _wrapperOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _wrapperController,
      curve: Curves.easeIn,
    ));

    // Logo animations
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.bounceOut,
    ));

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    ));

    // Ribbon animations
    _ribbonRotation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _ribbonController,
      curve: Curves.easeInOut,
    ));

    _ribbonSlide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -2.0),
    ).animate(CurvedAnimation(
      parent: _ribbonController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> _initializeApp() async {
    // await clearIfAppUpdated(); // Step 1: version check

    // Start the unwrapping animation sequence
    await _startUnwrappingAnimation();

    // Additional delay after animation
    await Future.delayed(const Duration(milliseconds: 800));

    _goToWalkThrough(); // Step 2: navigate
  }

  Future<void> _startUnwrappingAnimation() async {
    // Step 1: Show gift wrapper
    _wrapperController.forward();
    await Future.delayed(const Duration(milliseconds: 300));

    // Step 2: Animate ribbon flying away
    _ribbonController.forward();
    await Future.delayed(const Duration(milliseconds: 500));

    // Step 3: Reveal logo with bounce
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
  }

  // Future<bool> clearIfAppUpdated() async {
  //   final currentVersionCode = int.tryParse(AppConstants.appBuildNumber) ?? 0;
  //   final storedVersion = await _storage.getAppVersionCode();

  //   if (storedVersion == null || storedVersion < currentVersionCode) {
  //     await _storage.clearAll();
  //     await _storage.setAppVersionCode(currentVersionCode);
  //     return true; // Was updated
  //   }

  //   return false; // No update
  // }

  Future<void> _goToWalkThrough() async {
    final storage = ref.read(secureStorageHelperProvider);
    final rememberedEmail = await storage.getRememberedEmail();
    final rememberedPin = await storage.getPin(rememberedEmail ?? '');

    if (rememberedEmail != null && rememberedPin != null) {
      // Go to lock screen if email exists
      context.go(RouteConstants.lockScreen);
    } else {
      // Otherwise go to walkthrough
      context.go(RouteConstants.walkThrough);
    }
  }

  @override
  void dispose() {
    _wrapperController.dispose();
    _logoController.dispose();
    _ribbonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _wrapperController,
            _logoController,
            _ribbonController,
          ]),
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Gift wrapper/box
                Transform.scale(
                  scale: _wrapperScale.value,
                  child: Opacity(
                    opacity:
                        _wrapperOpacity.value * (1 - _logoOpacity.value * 0.7),
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: AppColors.background.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.background.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Ribbon that flies away
                Transform.translate(
                  offset: _ribbonSlide.value * 100,
                  child: Transform.rotate(
                    angle: _ribbonRotation.value * 3.14159,
                    child: Opacity(
                      opacity: (1 - _ribbonController.value).clamp(0.0, 1.0),
                      child: Container(
                        width: 200,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.background.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.background.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Vertical ribbon
                Transform.translate(
                  offset: _ribbonSlide.value * 100,
                  child: Transform.rotate(
                    angle: (_ribbonRotation.value * 3.14159) + (3.14159 / 2),
                    child: Opacity(
                      opacity: (1 - _ribbonController.value).clamp(0.0, 1.0),
                      child: Container(
                        width: 200,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.background.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.background.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Logo that appears after unwrapping
                Transform.scale(
                  scale: _logoScale.value,
                  child: Opacity(
                    opacity: _logoOpacity.value,
                    child: AppSvgIcon(
                      width: 150,
                      height: 150,
                      path: Assets.svgs.bundlegramWhiteLogo,
                      color: AppColors.background,
                    ),
                  ),
                ),

                // Sparkle effects around the logo
                if (_logoOpacity.value > 0.5)
                  ...List.generate(6, (index) {
                    final angle = (index * 60.0) * (3.14159 / 180);
                    final distance = 100.0;
                    final sparkleOpacity = (_logoOpacity.value - 0.5) * 2;

                    return Transform.translate(
                      offset: Offset(
                        distance * 0.8 * sparkleOpacity * (angle.abs()),
                        distance * 0.8 * sparkleOpacity * (angle.abs()),
                      ),
                      child: Transform.scale(
                        scale: _logoScale.value * 0.5,
                        child: Opacity(
                          opacity: sparkleOpacity * (1 - (index * 0.1)),
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.background.withOpacity(0.6),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              ],
            );
          },
        ),
      ),
    );
  }
}
