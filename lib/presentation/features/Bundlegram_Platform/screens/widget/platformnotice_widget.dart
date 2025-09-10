import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/account_setup_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/async_value/app_future_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// class PlatformNoticeWidget extends StatefulWidget {
//   const PlatformNoticeWidget({super.key});

//   @override
//   State<PlatformNoticeWidget> createState() => _PlatformNoticeWidgetState();
// }

// class _PlatformNoticeWidgetState extends State<PlatformNoticeWidget> {
//   int indexKey = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         final provider = ref.watch(accountSetupProvider);
//         final platform = ref.read(platformProvider);
//         final isAccountSetupComplete = provider.isAccountSetupComplete;
//         final profile = ref.watch(globalProvider).profile.value?.data;
//         final isAgent = profile?.userType?.toLowerCase() == "agent";

//         // Determine which slides to show based on state
//         final advertItems = <String>[];
//         final advertActions = <VoidCallback>[];

//         // if (!isAccountSetupComplete) {
//         advertItems.add(Assets.svgs.accountsetup);
//         advertActions.add(() => context.push(RouteConstants.accountSetup));
//         // }

//         // if (!isAgent) {
//         advertItems.add(Assets.images.becomeanagent.path);
//         advertActions.add(() => context.push(RouteConstants.becomeagent));
//         // }

//         advertItems.add(Assets.svgs.completesetup);
//         advertActions.add(
//           () => platform.goToProduct(context, PlatformProductType.mobileData),
//         );

//         // If nothing left to show, hide the entire carousel
//         if (advertItems.isEmpty) return const SizedBox.shrink();

//         return Column(
//           children: [
//             CarouselSlider(
//               items: List.generate(advertItems.length, (index) {
//                 bool isBecomeAgentItem =
//                     advertItems[index] == Assets.images.becomeanagent.path;

//                 return AppSvgIcon(
//                   onTap: advertActions[index],
//                   fit: BoxFit.scaleDown,
//                   path: advertItems[index],
//                   useCircleAvatar: false,
//                 );
//               }),
//               options: CarouselOptions(
//                 autoPlay: true,
//                 padEnds: false,
//                 onPageChanged: (c, _) => setState(() => indexKey = c),
//                 autoPlayInterval: const Duration(seconds: 3),
//                 enlargeCenterPage: true,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 advertItems.length,
//                 (index) => Container(
//                   width: indexKey == index ? 20.w : 6.w,
//                   height: 6.h,
//                   margin: context.symmetricPadding(4, 0),
//                   decoration: BoxDecoration(
//                     color: indexKey == index
//                         ? AppColors.primaryColor
//                         : AppColors.greyb3,
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
class PlatformNoticeWidget extends StatefulWidget {
  const PlatformNoticeWidget({super.key});

  @override
  State<PlatformNoticeWidget> createState() => _PlatformNoticeWidgetState();
}

class _PlatformNoticeWidgetState extends State<PlatformNoticeWidget> {
  int indexKey = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final provider = ref.watch(accountSetupProvider);
        final platform = ref.read(platformProvider);

        // 👇 Wrapping profile in AppAsyncBuilder
        final profileState = ref.watch(globalProvider).profile;

        return AppAsyncBuilder(
          state: profileState,
          onRetry: () =>
              ref.read(globalProvider.notifier).fetchProfile(context),
          builder: (context, ref, profileData) {
            final profile = profileData?.data;
            final isAgent = profile?.userType?.toLowerCase() == "agent";
            final isAccountSetupComplete = provider.isAccountSetupComplete;

            // Determine which slides to show based on state
            final advertItems = <String>[];
            final advertActions = <VoidCallback>[];

            // if (!isAccountSetupComplete) {
            advertItems.add(Assets.svgs.accountsetup);
            advertActions.add(() => context.push(RouteConstants.accountSetup));
            // }

            // if (!isAgent) {
            advertItems.add(Assets.svgs.becomeagent);
            advertActions.add(() => context.push(RouteConstants.becomeagent));
            // }

            advertItems.add(Assets.svgs.completesetup);
            advertActions.add(
              () =>
                  platform.goToProduct(context, PlatformProductType.mobileData),
            );

            advertItems.add(Assets.svgs.promoRewards);
            advertActions.add(() => context.push(RouteConstants.promo));

            // If nothing left to show, hide the entire carousel
            if (advertItems.isEmpty) return const SizedBox.shrink();

            return Column(
              children: [
                CarouselSlider(
                  items: List.generate(advertItems.length, (index) {
                    bool isBecomeAgentItem =
                        advertItems[index] == Assets.images.becomeanagent.path;

                    return AppSvgIcon(
                      onTap: advertActions[index],
                      fit: BoxFit.scaleDown,
                      path: advertItems[index],
                      useCircleAvatar: false,
                    );
                  }),
                  options: CarouselOptions(
                    autoPlay: true,
                    padEnds: false,
                    onPageChanged: (c, _) => setState(() => indexKey = c),
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    advertItems.length,
                    (index) => Container(
                      width: indexKey == index ? 20.w : 6.w,
                      height: 6.h,
                      margin: context.symmetricPadding(4, 0),
                      decoration: BoxDecoration(
                        color: indexKey == index
                            ? AppColors.primaryColor
                            : AppColors.greyb3,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
