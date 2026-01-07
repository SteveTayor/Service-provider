import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBar extends ConsumerWidget {
  const NavBar({
    super.key,
    this.useResponsive = true,
  });

  final bool useResponsive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;

    final items = [
      {
        'icon': Assets.svgs.homeinactive,
        'active': Assets.svgs.home,
        'name': 'Home',
      },
      {
        'icon': Assets.svgs.wallet,
        'active': Assets.svgs.walletactive,
        'name': 'Wallet',
      },
      {
        'icon': Assets.svgs.receipt,
        'active': Assets.svgs.receiptactive,
        'name': 'Transactions',
      },
      {
        'icon': Assets.svgs.userCircleSingleStreamlineCore,
        'active': Assets.svgs.userActive,
        'name': 'Account',
      },
    ];

    final currentIndex =
        ref.watch(dashboardProvider.select((p) => p.currentIndex));

    return Container(
      padding: EdgeInsets.fromLTRB(
        useResponsive ? r.spacing(20) : 20.w,
        useResponsive ? r.spacing(14) : 14.h,
        useResponsive ? r.spacing(20) : 20.w,
        useResponsive ? r.spacing(22) : 22.h,
      ),
      color: AppColors.background,
      width: double.infinity,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) => InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(dashboardProvider.notifier).onDestinationSelected(
                      index,
                    );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.identity()
                  ..scale(index == currentIndex ? 1.0 : 1.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSvgIcon(
                      path: index == currentIndex
                          ? '${items[index]['active']}'
                          : '${items[index]['icon']}',
                      width: 19.37.w,
                      height: 20.25.h,
                      fit: BoxFit.scaleDown,
                    ),
                    6.verticalSpace,
                    Text(
                      '${items[index]['name']}',
                      style: context.textTheme.labelMedium!.copyWith(
                        fontSize: 12,
                        color: AppColors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
