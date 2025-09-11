import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatFormDrawer extends ConsumerStatefulWidget {
  const PlatFormDrawer({super.key});

  @override
  ConsumerState<PlatFormDrawer> createState() => _PlatFormDrawerState();
}

class _PlatFormDrawerState extends ConsumerState<PlatFormDrawer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  List<Animation<Offset>> _slideAnimations = [];
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Start animation when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  void _initializeAnimations(int itemCount) {
    _slideAnimations = [];
    _fadeAnimations = [];

    for (int i = 0; i < itemCount; i++) {
      // Calculate staggered delay for each item
      final delay = i * 0.1; // 100ms delay between each item
      final animationStart = delay;
      final animationEnd = (delay + 0.5).clamp(0.0, 1.0);

      // Slide animation (from bottom to top)
      final slideAnimation = Tween<Offset>(
        begin: const Offset(0.0, 1.0), // Start from bottom
        end: Offset.zero, // End at original position
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          animationStart,
          animationEnd,
          curve: Curves.easeOutCubic,
        ),
      ));

      // Fade animation
      final fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          animationStart,
          animationEnd,
          curve: Curves.easeOut,
        ),
      ));

      _slideAnimations.add(slideAnimation);
      _fadeAnimations.add(fadeAnimation);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(platformProvider).userName;
    final global = ref.watch(globalProvider).profile;
    final profileProv = global.value?.data;
    final isAgent = profileProv?.userType == "agent";

    // Filter platformDrawerItem to exclude "Become an agent" if user is an agent
    final drawerItems = PlatFormData.platformDrawerItem
        .asMap()
        .entries
        .where((entry) {
          // Index 5 corresponds to "Become an agent" in platformDrawerItem
          if (isAgent && entry.key == 5) {
            return false; // Exclude "Become an agent" for agents
          }
          return true; // Include all other items
        })
        .map((entry) => entry.value)
        .toList();

    // Initialize animations based on the number of drawer items
    if (_slideAnimations.isEmpty ||
        _slideAnimations.length != drawerItems.length) {
      _initializeAnimations(drawerItems.length);
    }

    return Material(
      color: AppColors.background,
      child: SizedBox(
        width: 260.w,
        child: Stack(
          children: [
            ListView(
              children: [
                134.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    drawerItems.length,
                    (index) {
                      return AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return SlideTransition(
                            position: _slideAnimations[index],
                            child: FadeTransition(
                              opacity: _fadeAnimations[index],
                              child: drawerItems[index].withContainer(
                                padding: context.symmetricPadding(0, 10.h),
                                margin: context.symmetricPadding(20.w, 10.h),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      'Hi $userName',
                      style: context.textTheme.headlineMedium,
                    ),
                    8.horizontalSpace,
                    if (profileProv?.emailVerifiedAt != null &&
                        profileProv?.bvn != null &&
                        profileProv?.bankName != null &&
                        profileProv?.accountNumber != null) ...[
                      AppSvgIcon(
                          path:
                              Assets.svgs.warrantyBadgeHighlightStreamlineFlex)
                    ] else ...[
                      // AppSvgIcon(path: Assets.svgs.tickCircle),
                    ]
                  ],
                ),
                12.verticalSpace,
                if (isAgent)
                  Row(
                    children: [
                      AppSvgIcon(path: Assets.svgs.crownStreamlineFlex),
                      6.horizontalSpace,
                      Text(
                        'Bundlegram agent',
                        style: context.textTheme.bodySmall!.copyWith(
                          // fontSize: 14,
                          color: AppColors.greyF5,
                        ),
                      ),
                    ],
                  )
                else
                  const SizedBox(),
              ],
            ).withContainer(
              height: 152.h,
              padding: EdgeInsets.only(
                left: 20.w,
                bottom: 16.h,
              ),
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
