import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankdetailWidget extends StatelessWidget {
  const BankdetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Account 2',
              style: context.textTheme.bodySmall,
            ),
            AppSvgIcon(path: Assets.svgs.recycleBin2StreamlineCore),
          ],
        ),
        22.verticalSpace,
        Text(
          '4440883246',
          style: context.textTheme.titleLarge!.copyWith(
            fontSize: 40.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Guaranty Trust Bank',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.grey5B,
          ),
        ),
      ],
    ).withContainer(
      padding: context.symmetricPadding(24, 24),
      borderRadius: BorderRadius.circular(6.r),
      color: const Color(0xffF1F5FF),
    );
  }
}
