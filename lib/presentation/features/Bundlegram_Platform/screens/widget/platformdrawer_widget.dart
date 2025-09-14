import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
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
  late final AnimationController _animationController;
  List<Animation<Offset>> _slideAnimations = [];
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  void _initializeAnimations(int itemCount) {
    _slideAnimations = [];
    _fadeAnimations = [];

    for (int i = 0; i < itemCount; i++) {
      final delay = (i * 0.08).clamp(0.0, 1.0);
      final start = delay;
      final end = (delay + 0.6).clamp(0.0, 1.0);

      final slideAnim = Tween<Offset>(
        begin: Offset(-0.1, 1.2 + (i * 0.1)),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );

      final fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );

      _slideAnimations.add(slideAnim);
      _fadeAnimations.add(fadeAnim);
    }
  }

  Widget _buildAnimatedListItem(Widget item, int index) {
    if (_slideAnimations.length <= index || _fadeAnimations.length <= index) {
      return item.withContainer(
        padding: context.symmetricPadding(0, 10.h),
        margin: context.symmetricPadding(20.w, 8.h),
      );
    }

    return SlideTransition(
      position: _slideAnimations[index],
      child: FadeTransition(
        opacity: _fadeAnimations[index],
        child: item.withContainer(
          padding: context.symmetricPadding(0, 10.h),
          margin: context.symmetricPadding(20.w, 8.h),
        ),
      ),
    );
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

    final drawerItems = PlatFormData.platformDrawerItem
        .asMap()
        .entries
        .where((entry) {
          if (isAgent && entry.key == 5) return false;
          return true;
        })
        .map((entry) => entry.value)
        .toList();

    if (_slideAnimations.isEmpty ||
        _slideAnimations.length != drawerItems.length) {
      _initializeAnimations(drawerItems.length);
    }

    return Material(
      color: AppColors.background,
      child: SizedBox(
        width: 260.w,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // Sticky Header
            SliverPersistentHeader(
              pinned: true,
              delegate: _DrawerHeaderDelegate(
                minExtentHeight: 120.h,
                maxExtentHeight: 152.h,
                userName: userName,
                profileProv: profileProv,
                isAgent: isAgent,
                context: context,
              ),
            ),

            // Drawer items
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildAnimatedListItem(drawerItems[index], index);
                },
                childCount: drawerItems.length,
              ),
            ),

            // Bottom spacing
            SliverToBoxAdapter(
              child: 60.verticalSpace,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtentHeight;
  final double maxExtentHeight;
  final String userName;
  final dynamic profileProv;
  final bool isAgent;
  final BuildContext context;

  _DrawerHeaderDelegate({
    required this.minExtentHeight,
    required this.maxExtentHeight,
    required this.userName,
    required this.profileProv,
    required this.isAgent,
    required this.context,
  });

  @override
  double get minExtent => minExtentHeight;
  @override
  double get maxExtent => maxExtentHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtentHeight,
      padding: EdgeInsets.only(left: 20.w, bottom: 16.h),
      color: AppColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Hi $userName', style: context.textTheme.headlineMedium),
              8.horizontalSpace,
              if (profileProv?.emailVerifiedAt != null &&
                  profileProv?.bvn != null &&
                  profileProv?.bankName != null &&
                  profileProv?.accountNumber != null)
                AppSvgIcon(
                    path: Assets.svgs.warrantyBadgeHighlightStreamlineFlex),
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
                    color: AppColors.greyF5,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _DrawerHeaderDelegate oldDelegate) {
    return oldDelegate.userName != userName ||
        oldDelegate.isAgent != isAgent ||
        oldDelegate.profileProv != profileProv;
  }
}
