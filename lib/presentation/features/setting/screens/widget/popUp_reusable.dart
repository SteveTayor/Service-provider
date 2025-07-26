import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SecurityPopWidget extends StatelessWidget {
  final String popHeader;
  final String popContent;
  final String popButtonTitle;
  final VoidCallback? onConfirm; // Add callback for confirm action

  const SecurityPopWidget({
    required this.popHeader,
    required this.popContent,
    required this.popButtonTitle,
    this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            popHeader,
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          12.verticalSpace,
          Text(
            popContent,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall,
          ),
          28.verticalSpace,
          BundlegramButton(
            text: popButtonTitle,
            onPressed: () {
              // Call the confirm callback if provided
              if (onConfirm != null) {
                onConfirm!();
              } else {
                // Default behavior - navigate to dashboard
                context.push(RouteConstants.dashboard);
              }
            },
          ),
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
