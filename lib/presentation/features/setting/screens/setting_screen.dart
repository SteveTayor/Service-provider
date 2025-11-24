import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/setting/screens/closeaccount_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen>
    with TickerProviderStateMixin {
  late AnimationController _listController;
  late List<Animation<double>> _itemAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();

    _listController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Create animations for each list item (6 items total)
    _itemAnimations = List.generate(6, (index) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _listController,
        curve: Interval(
          index * 0.1, // Stagger each item by 100ms
          0.7 + (index * 0.05), // End at different times for wave effect
          curve: Curves.easeOutCubic,
        ),
      ));
    });

    _slideAnimations = List.generate(6, (index) {
      return Tween<Offset>(
        begin: const Offset(0.3, 0), // Slide in from right
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _listController,
        curve: Interval(
          index * 0.08,
          0.6 + (index * 0.06),
          curve: Curves.easeOutBack,
        ),
      ));
    });

    // Start animation after screen builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listController.forward();
    });
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedListItem({
    required Widget child,
    required int index,
    bool isDestructive = false,
  }) {
    return AnimatedBuilder(
      animation: _listController,
      builder: (context, _) {
        final opacity = _itemAnimations[index].value;
        final slide = _slideAnimations[index].value;

        return SlideTransition(
          position: Tween<Offset>(
            begin: slide,
            end: Offset.zero,
          ).animate(_listController),
          child: FadeTransition(
            opacity: _itemAnimations[index],
            child: Transform.scale(
              scale: 0.95 + (0.05 * opacity),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateY((1 - opacity) * 0.1), // Subtle 3D rotation
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalUserProvider = ref.watch(globalProvider).profile;
    final profileProv = globalUserProvider.value?.data;

    Widget buildRowWidget(String asset, String title, int index,
        {VoidCallback? onPressed, bool isDestructive = false}) {
      return _buildAnimatedListItem(
        index: index,
        isDestructive: isDestructive,
        child: AppListTile(
          onPressed: onPressed,
          assetPath: asset,
          trailingAsset: Assets.svgs.arrowFowardIos,
          title: title,
          titleColor: isDestructive ? AppColors.errorText : null,
        ).withContainer(
          padding: context.symmetricPadding(0, 24),
          border: const Border(bottom: BorderSide(color: Color(0xffECECEC))),
        ),
      );
    }

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Settings',
      ),
      body: Column(
        children: [
          buildRowWidget(
            Assets.svgs.userProtection2StreamlineCore,
            'Change password',
            0,
            onPressed: () {
              final email = profileProv?.email;
              context.push(RouteConstants.changePassword, extra: email);
            },
          ),
          buildRowWidget(
            Assets.svgs.browserLockStreamlineCore,
            'Change account pin',
            1,
            onPressed: () {
              context.push(RouteConstants.changeAccountPin);
            },
          ),
          buildRowWidget(
            Assets.svgs.lockRotationStreamlineCore,
            'Reset account pin',
            2,
            onPressed: () {
              context.push(RouteConstants.resetAccountPin);
            },
          ),
          buildRowWidget(
            Assets.svgs.ringingBellNotificationStreamlineCore,
            'Notifications settings',
            3,
            onPressed: () {
              context.push(RouteConstants.notificationsetting);
            },
          ),
          buildRowWidget(
            Assets.svgs.vpnConnectionStreamlineCore,
            'Privacy & Security',
            4,
            onPressed: () {
              context.push(RouteConstants.privacySecurity);
            },
          ),
          buildRowWidget(
            Assets.svgs.browserDeleteStreamlineCore,
            'Close account',
            5,
            isDestructive: true,
            onPressed: () {
              context.showBottomSheet(child: const CloseaccountWidget());
            },
          ),
        ],
      ),
    );
  }
}

// Alternative version with simpler but smooth animations
class SettingScreenSimple extends ConsumerStatefulWidget {
  const SettingScreenSimple({super.key});

  @override
  ConsumerState<SettingScreenSimple> createState() =>
      _SettingScreenSimpleState();
}

class _SettingScreenSimpleState extends ConsumerState<SettingScreenSimple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Start animation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStaggeredItem({
    required Widget child,
    required int index,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset((1 - value) * 50, 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalUserProvider = ref.watch(globalProvider).profile;
    final profileProv = globalUserProvider.value?.data;

    Widget buildRowWidget(String asset, String title, int index,
        {VoidCallback? onPressed, bool isDestructive = false}) {
      return _buildStaggeredItem(
        index: index,
        child: AppListTile(
          onPressed: onPressed,
          assetPath: asset,
          trailingAsset: Assets.svgs.arrowFowardIos,
          title: title,
          titleColor: isDestructive ? AppColors.errorText : null,
        ).withContainer(
          padding: context.symmetricPadding(0, 24),
          border: const Border(bottom: BorderSide(color: Color(0xffECECEC))),
        ),
      );
    }

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Settings',
      ),
      body: Column(
        children: [
          buildRowWidget(
            Assets.svgs.userProtection2StreamlineCore,
            'Change password',
            0,
            onPressed: () {
              final email = profileProv?.email;
              context.push(RouteConstants.changePassword, extra: email);
            },
          ),
          buildRowWidget(
            Assets.svgs.browserLockStreamlineCore,
            'Change account pin',
            1,
            onPressed: () {
              context.push(RouteConstants.changeAccountPin);
            },
          ),
          buildRowWidget(
            Assets.svgs.lockRotationStreamlineCore,
            'Reset account pin',
            2,
            onPressed: () {
              context.push(RouteConstants.resetAccountPin);
            },
          ),
          buildRowWidget(
            Assets.svgs.ringingBellNotificationStreamlineCore,
            'Notifications settings',
            3,
            onPressed: () {
              context.push(RouteConstants.notificationsetting);
            },
          ),
          buildRowWidget(
            Assets.svgs.vpnConnectionStreamlineCore,
            'Privacy & Security',
            4,
            onPressed: () {
              context.push(RouteConstants.privacySecurity);
            },
          ),
          buildRowWidget(
            Assets.svgs.browserDeleteStreamlineCore,
            'Close account',
            5,
            isDestructive: true,
            onPressed: () {
              context.showBottomSheet(child: const CloseaccountWidget());
            },
          ),
        ],
      ),
    );
  }
}
