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

class PlatFormDrawer extends ConsumerWidget {
  const PlatFormDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      return drawerItems[index].withContainer(
                        padding: context.symmetricPadding(0, 10.h),
                        margin: context.symmetricPadding(20.w, 10.h),
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
                      AppSvgIcon(path: Assets.svgs.tickCircle),
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
                bottom: 20.h,
              ),
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
