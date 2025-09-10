import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({
    required this.title,
    required this.subText,
    required this.buttonText,
    required this.onPressed,
    required this.appIcon,
    super.key,
    this.isLinkSent = false,
    this.iconPath,
  });
  final String title;
  final String subText;
  final bool? isLinkSent;
  final String? iconPath;
  final String buttonText;
  final VoidCallback onPressed;
  final Widget appIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appIcon,
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineLarge
                    ?.copyWith(color: AppColors.grey19),
              ),
              12.verticalSpace,
              Text(
                subText,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 18, color: AppColors.resultwidgetColor),
              ),
            ],
          ),
        ),
        BundlegramButton(text: buttonText, onPressed: onPressed),
      ],
    );
  }
}
