import 'dart:developer';

import 'package:bundlegram/presentation/features/account%20setup/notifier/account_setup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';

class AccountsetupScreen extends ConsumerStatefulWidget {
  const AccountsetupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountsetupScreen> createState() => _AccountsetupScreenState();
}

class _AccountsetupScreenState extends ConsumerState<AccountsetupScreen> {
  @override
  void initState() {
    super.initState();
    // fetch banks once on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // run in a microtask so we can use async/await safely
      Future.microtask(() async {
        try {
          await ref.read(globalProvider.notifier).fetchBanks(context);
        } catch (e, st) {
          // log but do not rethrow — prevents framework error overlay
          log('fetchBanks() failed in AccountsetupScreen: $e', stackTrace: st);
        }
        try {
          await ref.read(globalProvider.notifier).fetchProfile(context);
        } catch (e, st) {
          log('fetchProfile() failed in AccountsetupScreen: $e',
              stackTrace: st);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(accountSetupProvider);
    final steps = provider.steps;
    final profileAsync = ref.watch(globalProvider).profile;
    // final firstName = profileAsync.value?.data?.firstName ?? '';
    // final profileAsync = ref.watch(globalProvider).profile;
    String firstName = '';
    try {
      firstName = profileAsync.value?.data?.firstName ?? '';
    } catch (_) {
      // defensive: if accessing value throws, swallow and use empty string
      firstName = '';
    }
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Complete account set up',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Hi ${firstName.isNotEmpty ? firstName : 'there'}, finish setting up your account to enjoy Bundlegram fully.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),
            24.verticalSpace,
            // Progress indicator bar
            SizedBox(
              height: 10.h,
              child: Row(
                children: steps.map((step) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: step.done
                            ? AppColors.primaryColor
                            : AppColors.greyd9,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            48.verticalSpace,
            // Step list
            Column(
              children: steps.map((step) {
                return InkWell(
                  onTap: step.done
                      ? null
                      : () => provider.onStepTap(step, context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppSvgIcon(path: step.asset),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step.title,
                                style: context.textTheme.bodyMedium),
                            8.verticalSpace,
                            Text(step.label,
                                style: context.textTheme.labelMedium),
                          ],
                        ),
                      ),
                      AppSvgIcon(
                        path: step.done
                            ? Assets.svgs.check
                            : Assets.svgs.unveirifycheck,
                      ),
                    ],
                  ).withContainer(
                    padding: context.symmetricPadding(0, 8),
                    margin: EdgeInsets.only(bottom: 24.h),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// class AccountsetupScreen extends ConsumerWidget {
//   const AccountsetupScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final global = ref.watch(globalProvider).profile;
//     final accountProfile = global.value?.data;
//     // Define the list of steps with their data
//     final List<Map<String, dynamic>> steps = [
//       {
//         'asset': Assets.svgs.createaccount,
//         'title': 'Create account',
//         'label': 'Create a Bundlegram account',
//         'verify': true,
//       },
//       {
//         'asset': Assets.svgs.verifyemail,
//         'title': 'Verify email',
//         'label': 'Verify your email for security purpose',
//         'verify': false,
//         'onPressed': () =>
//             context.showBottomSheet(child: const VerifyemailWidget()),
//       },
//       {
//         'asset': Assets.svgs.addbasicinfo,
//         'title': 'Add basic information',
//         'label': 'Let’s know more about you',
//         'verify': false,
//         'onPressed': () => context.push(RouteConstants.addbasicinformation),
//       },
//       {
//         'asset': Assets.svgs.linkyourbvn,
//         'title': 'Link your BVN',
//         'label': 'Link BVN to be able to withdraw',
//         'verify': false,
//         'onPressed': () => context.push(RouteConstants.linkyourbvn),
//       },
//       {
//         'asset': Assets.svgs.addbankdetail,
//         'title': 'Add bank details',
//         'label': 'Save bank details to withdraw later',
//         'verify': false,
//         'onPressed': () => context.push(RouteConstants.addbankdetail),
//       },
//     ];

//     // Helper method to build each step row
//     Widget buildItemRow(
//       String asset,
//       String title,
//       String label,
//       bool verify, {
//       VoidCallback? onPressed,
//     }) {
//       return InkWell(
//         onTap: onPressed,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             AppSvgIcon(path: asset),
//             12.horizontalSpace,
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: context.textTheme.bodyMedium,
//                   ),
//                   8.verticalSpace,
//                   Text(
//                     label,
//                     style: context.textTheme.labelMedium,
//                   ),
//                 ],
//               ),
//             ),
//             AppSvgIcon(
//               path: verify ? Assets.svgs.check : Assets.svgs.unveirifycheck,
//             ),
//           ],
//         ).withContainer(
//           padding: context.symmetricPadding(0, 8),
//           margin: EdgeInsets.only(bottom: 24.h),
//         ),
//       );
//     }

//     return BundlegramScaffold(
//       appBar: const BundlegramAppbar(
//         titleText: 'Complete account set up',
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text(
//               'Hi ${accountProfile?.firstName}, finish setting up your account to enjoy Bundlegram fully.',
//               textAlign: TextAlign.center,
//               style: context.textTheme.bodyMedium!.copyWith(
//                 color: AppColors.grey33,
//               ),
//             ),
//             24.verticalSpace,
//             // Progress bar reflecting step completion
//             SizedBox(
//               height: 10.h,
//               child: Row(
//                 children: List.generate(steps.length, (index) {
//                   return Expanded(
//                     child: Container(
//                       margin: context.symmetricPadding(4, 0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         color: (steps[index]['verify'] as bool)
//                             ? AppColors.primaryColor
//                             : AppColors.greyd9,
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             48.verticalSpace,
//             // List of steps using spread operator
//             Column(
//                 children: steps
//                     .map((step) => buildItemRow(
//                           step['asset'] as String,
//                           step['title'] as String,
//                           step['label'] as String,
//                           step['verify'] as bool,
//                           onPressed: step['onPressed'] as VoidCallback?,
//                         ))
//                     .toList()),
//           ],
//         ),
//       ),
//     );
//   }
// }
