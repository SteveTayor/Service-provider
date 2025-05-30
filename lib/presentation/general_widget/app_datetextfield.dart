import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDatetextfield extends StatelessWidget {
  const AppDatetextfield({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall,
        ),
        AppSvgIcon(
          path: Assets.svgs.calendar,
        ),
      ],
    ).withContainer(
      padding: context.symmetricPadding(16, 23),
      borderRadius: BorderRadius.circular(6.r),
      color: AppColors.white,
      border: Border.all(
        color: AppColors.greyD0,
      ),
    );
  }
}
