import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/verifyemail_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountsetupScreen extends StatelessWidget {
  const AccountsetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the list of steps with their data
    final List<Map<String, dynamic>> steps = [
      {
        'asset': Assets.svgs.createaccount,
        'title': 'Create account',
        'label': 'Create a Bundlegram account',
        'verify': true,
      },
      {
        'asset': Assets.svgs.verifyemail,
        'title': 'Verify email',
        'label': 'Verify your email for security purpose',
        'verify': false,
        'onPressed': () =>
            context.showBottomSheet(child: const VerifyemailWidget()),
      },
      {
        'asset': Assets.svgs.addbasicinfo,
        'title': 'Add basic information',
        'label': 'Let’s know more about you',
        'verify': false,
        'onPressed': () => context.push(RouteConstants.addbasicinformation),
      },
      {
        'asset': Assets.svgs.linkyourbvn,
        'title': 'Link your BVN',
        'label': 'Link BVN to be able to withdraw',
        'verify': false,
        'onPressed': () => context.push(RouteConstants.linkyourbvn),
      },
      {
        'asset': Assets.svgs.addbankdetail,
        'title': 'Add bank details',
        'label': 'Save bank details to withdraw later',
        'verify': false,
        'onPressed': () => context.push(RouteConstants.addbankdetail),
      },
    ];

    // Helper method to build each step row
    Widget buildItemRow(
      String asset,
      String title,
      String label,
      bool verify, {
      VoidCallback? onPressed,
    }) {
      return InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSvgIcon(path: asset),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium,
                  ),
                  8.verticalSpace,
                  Text(
                    label,
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            AppSvgIcon(
              path: verify ? Assets.svgs.check : Assets.svgs.unveirifycheck,
            ),
          ],
        ).withContainer(
          padding: context.symmetricPadding(0, 8),
          margin: EdgeInsets.only(bottom: 24.h),
        ),
      );
    }

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Complete account set up',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Hi Rose, finish setting up your account to enjoy Bundlegram fully.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.grey33,
              ),
            ),
            24.verticalSpace,
            // Progress bar reflecting step completion
            SizedBox(
              height: 10.h,
              child: Row(
                children: List.generate(steps.length, (index) {
                  return Expanded(
                    child: Container(
                      margin: context.symmetricPadding(4, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: (steps[index]['verify'] as bool)
                            ? AppColors.primaryColor
                            : AppColors.greyd9,
                      ),
                    ),
                  );
                }),
              ),
            ),
            48.verticalSpace,
            // List of steps using spread operator
            Column(
                children: steps
                    .map((step) => buildItemRow(
                          step['asset'] as String,
                          step['title'] as String,
                          step['label'] as String,
                          step['verify'] as bool,
                          onPressed: step['onPressed'] as VoidCallback?,
                        ))
                    .toList()),
          ],
        ),
      ),
    );
  }
}
