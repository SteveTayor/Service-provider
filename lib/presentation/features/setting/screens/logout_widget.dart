import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Log out',
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 18.sp,
            ),
          ),
          12.verticalSpace,
          Text(
            'Are you sure you want to log out?',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall,
          ),
          28.verticalSpace,
          BundlegramButton(
              text: 'Log out', color: AppColors.logOut, onPressed: () {}),
          24.verticalSpace,
          BundlegramButton(
            isOutline: true,
            borderColor: AppColors.greyD0,
            buttonStyle: BundlegramButtonOutline(),
            text: 'Cancel',
            onPressed: () {
              context.pop();
            },
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
