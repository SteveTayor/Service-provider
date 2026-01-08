// import 'dart:async';

// import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
// import 'package:bundlegram/presentation/features/onboarding/notifier/onboard_notifier.dart';
// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/router/route_constants.dart';
// import 'package:bundlegram/presentation/features/onboarding/notifier/onboarding_data.dart';
// import 'package:bundlegram/gen/assets.gen.dart';
// import 'package:bundlegram/presentation/general_widget/app_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:permission_handler/permission_handler.dart';

// class WalkthroughScreen extends ConsumerStatefulWidget {
//   const WalkthroughScreen({super.key});

//   @override
//   ConsumerState<WalkthroughScreen> createState() => _WalkthroughScreenState();
// }

// class _WalkthroughScreenState extends ConsumerState<WalkthroughScreen> {
//   @override
//   void initState() {
//     super.initState();
//     final storage = ref.read(secureStorageHelperProvider)
//       ..setHasSeenPromoModal(false);
//     _checkAndRequestPermissions();
//   }

//   Future<void> _checkAndRequestPermissions() async {
//     final locationStatus = await Permission.location.request();

//     if (locationStatus.isPermanentlyDenied) {
//       _showPermissionDialog();
//     }
//   }

//   void _showPermissionDialog() {
//     showCupertinoDialog(
//       context: context,
//       builder: (_) => CupertinoAlertDialog(
//         title: const Text('Permission Required'),
//         content: const Text(
//           'Location permission is permanently denied. Please enable it manually in the app settings.',
//         ),
//         actions: [
//           CupertinoDialogAction(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             onPressed: () {
//               Navigator.pop(context);
//               openAppSettings();
//             },
//             child: const Text('Open Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final notifier = ref.read(onboardingNotifierProvider.notifier);
//     final walkthroughIndex = ref.watch(
//       onboardingNotifierProvider.select((v) => v.walkThroughIndex),
//     );

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               50.verticalSpace,
//               Expanded(
//                 child: PageView(
//                   onPageChanged: notifier.updateWalkThroughIndex,
//                   children:
//                       List.generate(OnboardingData.walkthrough.length, (index) {
//                     return Column(
//                       children: [
//                         Text(
//                           OnboardingData.walkthrough[index]['name']!
//                               .toUpperCase(),
//                           textAlign: TextAlign.center,
//                           style: context.textTheme.titleLarge,
//                         ),
//                         14.verticalSpace,
//                         Text(
//                           OnboardingData.walkthrough[index]['subText']!,
//                           textAlign: TextAlign.center,
//                           style: context.textTheme.bodySmall,
//                         ),
//                         Expanded(
//                           child: Center(
//                             child: AssetGenImage(
//                               OnboardingData.walkthrough[index]['icon']!,
//                             ).image(),
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
//                 ),
//               ),
//               20.verticalSpace,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(3, (index) {
//                   return Container(
//                     margin: EdgeInsets.symmetric(horizontal: 6.h),
//                     width: walkthroughIndex == index ? 20.w : 6.w,
//                     height: 6.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(3.r),
//                       color: index == walkthroughIndex
//                           ? Colors.black
//                           : const Color(0xffB3B3B3),
//                     ),
//                   );
//                 }),
//               ),
//               30.verticalSpace,
//               BundlegramButton(
//                 text: 'Create account',
//                 onPressed: () => context.go(RouteConstants.register),
//               ),
//               25.verticalSpace,
//               InkWell(
//                 onTap: () async {
//                   final storage = ref.read(secureStorageHelperProvider);
//                   final rememberedEmail = await storage.getRememberedEmail();

//                   if (rememberedEmail != null) {
//                     // Go to lock screen if email exists
//                     unawaited(context.push(RouteConstants.lockScreen));
//                   } else {
//                     // Otherwise go to login
//                     unawaited(context.push(RouteConstants.login));
//                   }
//                 },
//                 child: Text(
//                   'I already have an account',
//                   style: context.textTheme.bodyMedium,
//                 ),
//               ),
//               20.verticalSpace,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:math' as math;

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

class _WalkthroughScreenState extends ConsumerState<WalkthroughScreen>
    with TickerProviderStateMixin {
  late AnimationController _bottomAnimationController;
  late AnimationController _backgroundController;
  late Animation<Offset> _bottomSlideAnimation;
  late Animation<double> _bottomFadeAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    final storage = ref.read(secureStorageHelperProvider)
      ..setHasSeenPromoModal(false);
    _checkAndRequestPermissions();

    // Background gradient animation
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_backgroundController);

    // Bottom content animation - smooth and balanced timing
    _bottomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _bottomSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _bottomAnimationController,
      curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
    ));

    _bottomFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bottomAnimationController,
      curve: const Interval(0.2, 0.9, curve: Curves.easeOut),
    ));

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _bottomAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _bottomAnimationController.dispose();
    _backgroundController.dispose();
    super.dispose();
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
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Color.lerp(
                    const Color(0xFFFAFAFA),
                    const Color(0xFFF0F0F0),
                    _backgroundAnimation.value,
                  )!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                50.verticalSpace,
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      notifier.updateWalkThroughIndex(index);
                      // Restart bottom animation on page change
                      _bottomAnimationController.reset();
                      _bottomAnimationController.forward();
                    },
                    itemCount: OnboardingData.walkthrough.length,
                    itemBuilder: (context, index) {
                      return _PremiumPageContent(
                        key: ValueKey(index),
                        index: index,
                        data: OnboardingData.walkthrough[index],
                        isActive: index == walkthroughIndex,
                      );
                    },
                  ),
                ),
                20.verticalSpace,
                // SlideTransition(
                //   position: _bottomSlideAnimation,
                //   child: FadeTransition(
                //     opacity: _bottomFadeAnimation,
                //     child:
                Column(
                  children: [
                    _AnimatedPageIndicators(
                      currentIndex: walkthroughIndex,
                      count: 3,
                    ),
                    30.verticalSpace,
                    _AnimatedButton(
                      text: 'Create account',
                      onPressed: () => context.push(RouteConstants.register),
                      isPrimary: true,
                    ),
                    25.verticalSpace,
                    InkWell(
                      onTap: () async {
                        final storage = ref.read(secureStorageHelperProvider);
                        final rememberedEmail =
                            await storage.getRememberedEmail();
                        final rememberedPin =
                            await storage.getPin(rememberedEmail ?? '');

                        if (rememberedEmail != null && rememberedPin != null) {
                          unawaited(context.push(RouteConstants.lockScreen));
                        } else {
                          unawaited(context.push(RouteConstants.login));
                        }
                      },
                      child: Text(
                        'I already have an account',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumPageContent extends StatefulWidget {
  final int index;
  final Map<String, String> data;
  final bool isActive;

  const _PremiumPageContent({
    required super.key,
    required this.index,
    required this.data,
    required this.isActive,
  });

  @override
  State<_PremiumPageContent> createState() => _PremiumPageContentState();
}

class _PremiumPageContentState extends State<_PremiumPageContent>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _floatingController;
  late AnimationController _rotationController;

  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _titleScaleAnimation;

  late Animation<Offset> _subtitleSlideAnimation;
  late Animation<double> _subtitleFadeAnimation;

  late Animation<Offset> _imageSlideAnimation;
  late Animation<double> _imageFadeAnimation;
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    // Main animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Floating effect controller
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    // Subtle rotation controller
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(
      begin: -0.02,
      end: 0.02,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    // Title animations - dramatic entrance with scale
    final titleDirection = widget.index % 2 == 0 ? -0.5 : 0.5;
    _titleSlideAnimation = Tween<Offset>(
      begin: Offset(titleDirection, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    ));

    _titleFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    ));

    _titleScaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
    ));

    // Subtitle animations - slightly delayed
    _subtitleSlideAnimation = Tween<Offset>(
      begin: Offset(titleDirection * 0.8, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.6, curve: Curves.easeOutCubic),
    ));

    _subtitleFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.5, curve: Curves.easeIn),
    ));

    // Image animations - opposite direction with bounce
    final imageDirection = widget.index % 2 == 0 ? 0.6 : -0.6;
    _imageSlideAnimation = Tween<Offset>(
      begin: Offset(imageDirection, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.9, curve: Curves.easeOutCubic),
    ));

    _imageFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.8, curve: Curves.easeIn),
    ));

    _imageScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.9, curve: Curves.elasticOut),
    ));
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void didUpdateWidget(_PremiumPageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      _controller.reset();
      _startAnimations();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _floatingController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Decorative circles in background
        Positioned(
          top: 50,
          right: 30,
          child: _DecorativeCircle(
            size: 60,
            color: Colors.white.withOpacity(0.03),
            delay: 0,
          ),
        ),
        Positioned(
          top: 150,
          left: 20,
          child: _DecorativeCircle(
            size: 80,
            color: Colors.white.withOpacity(0.02),
            delay: 200,
          ),
        ),

        Column(
          children: [
            // Animated title
            SlideTransition(
              position: _titleSlideAnimation,
              child: FadeTransition(
                opacity: _titleFadeAnimation,
                child: ScaleTransition(
                  scale: _titleScaleAnimation,
                  child: Text(
                    widget.data['name']!.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
            14.verticalSpace,
            // Animated subtitle
            SlideTransition(
              position: _subtitleSlideAnimation,
              child: FadeTransition(
                opacity: _subtitleFadeAnimation,
                child: Text(
                  widget.data['subText']!,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.copyWith(
                    height: 1.5,
                  ),
                ),
              ),
            ),
            // Animated image with floating effect
            Expanded(
              child: Center(
                child: SlideTransition(
                  position: _imageSlideAnimation,
                  child: FadeTransition(
                    opacity: _imageFadeAnimation,
                    child: ScaleTransition(
                      scale: _imageScaleAnimation,
                      child: AnimatedBuilder(
                        animation: Listenable.merge([
                          _floatingAnimation,
                          _rotationAnimation,
                        ]),
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _floatingAnimation.value),
                            child: Transform.rotate(
                              angle: _rotationAnimation.value,
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.05),
                                blurRadius: 30,
                                spreadRadius: 5,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: AssetGenImage(
                            widget.data['icon']!,
                          ).image(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DecorativeCircle extends StatefulWidget {
  final double size;
  final Color color;
  final int delay;

  const _DecorativeCircle({
    required this.size,
    required this.color,
    required this.delay,
  });

  @override
  State<_DecorativeCircle> createState() => _DecorativeCircleState();
}

class _DecorativeCircleState extends State<_DecorativeCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}

class _AnimatedPageIndicators extends StatelessWidget {
  final int currentIndex;
  final int count;

  const _AnimatedPageIndicators({
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          margin: EdgeInsets.symmetric(horizontal: 6.h),
          width: isActive ? 24.w : 6.w,
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            color: isActive ? Colors.black : const Color(0xffB3B3B3),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _AnimatedButton({
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: BundlegramButton(
          text: widget.text,
          onPressed: widget.onPressed, // Handled by GestureDetector
        ),
      ),
    );
  }
}
