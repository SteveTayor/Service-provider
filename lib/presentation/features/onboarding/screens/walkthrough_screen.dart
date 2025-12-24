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
    with SingleTickerProviderStateMixin {
  late AnimationController _bottomAnimationController;
  late Animation<Offset> _bottomSlideAnimation;
  late Animation<double> _bottomFadeAnimation;

  @override
  void initState() {
    super.initState();
    final storage = ref.read(secureStorageHelperProvider)
      ..setHasSeenPromoModal(false);
    _checkAndRequestPermissions();

    // Initialize bottom content animation
    _bottomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _bottomSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _bottomAnimationController,
      curve: Curves.easeOut,
    ));

    _bottomFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bottomAnimationController,
      curve: Curves.easeIn,
    ));

    // Start animation after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _bottomAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _bottomAnimationController.dispose();
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              50.verticalSpace,
              Expanded(
                child: PageView.builder(
                  onPageChanged: notifier.updateWalkThroughIndex,
                  itemCount: OnboardingData.walkthrough.length,
                  itemBuilder: (context, index) {
                    return _AnimatedPageContent(
                      key: ValueKey(index),
                      index: index,
                      data: OnboardingData.walkthrough[index],
                      isActive: index == walkthroughIndex,
                    );
                  },
                ),
              ),
              20.verticalSpace,
              // Animated bottom content
              SlideTransition(
                position: _bottomSlideAnimation,
                child: FadeTransition(
                  opacity: _bottomFadeAnimation,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
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
                          final rememberedEmail =
                              await storage.getRememberedEmail();

                          if (rememberedEmail != null) {
                            unawaited(context.push(RouteConstants.lockScreen));
                          } else {
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
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedPageContent extends StatefulWidget {
  final int index;
  final Map<String, String> data;
  final bool isActive;

  const _AnimatedPageContent({
    required super.key,
    required this.index,
    required this.data,
    required this.isActive,
  });

  @override
  State<_AnimatedPageContent> createState() => _AnimatedPageContentState();
}

class _AnimatedPageContentState extends State<_AnimatedPageContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<double> _imageFadeAnimation;
  late Animation<double> _imageScaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Text animations - alternating slide direction based on index
    final textDirection = widget.index % 2 == 0 ? -0.3 : 0.3;
    _textSlideAnimation = Tween<Offset>(
      begin: Offset(textDirection, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    // Image animations - slide from opposite direction + scale
    final imageDirection = widget.index % 2 == 0 ? 0.3 : -0.3;
    _imageSlideAnimation = Tween<Offset>(
      begin: Offset(imageDirection, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _imageFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.7, curve: Curves.easeIn),
    ));

    _imageScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
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
  void didUpdateWidget(_AnimatedPageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      _controller.reset();
      _startAnimations();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated title and subtitle
        SlideTransition(
          position: _textSlideAnimation,
          child: FadeTransition(
            opacity: _textFadeAnimation,
            child: Column(
              children: [
                Text(
                  widget.data['name']!.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge,
                ),
                14.verticalSpace,
                Text(
                  widget.data['subText']!,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        // Animated image
        Expanded(
          child: Center(
            child: SlideTransition(
              position: _imageSlideAnimation,
              child: FadeTransition(
                opacity: _imageFadeAnimation,
                child: ScaleTransition(
                  scale: _imageScaleAnimation,
                  child: AssetGenImage(
                    widget.data['icon']!,
                  ).image(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
