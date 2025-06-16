import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/resetpasswordlink_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VerifyemailWidget extends StatelessWidget {
  const VerifyemailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String userEmail = 'roseowen@gmail.com';
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Verify email',
            style: context.textTheme.headlineMedium!.copyWith(
              color: AppColors.black,
            ),
          ),
          12.verticalSpace,
          Text(
            textAlign: TextAlign.center,
            'Please, confirm your email address before we will send a verification link.',
            style: context.textTheme.bodySmall,
          ),
          24.verticalSpace,
          const AppTextField(
            hintText: 'Email',
          ),
          40.verticalSpace,
          BundlegramButton(
            text: 'Confirm email',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ResetPasswordLinkScreen(
                    title: 'Verification link sent!',
                    subtitle:
                        'Verify your email, ${userEmail}, to start paying your bills with Bundlegram.',
                  ),
                ),
              );
            },
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
