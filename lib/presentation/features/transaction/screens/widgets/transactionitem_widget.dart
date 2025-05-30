import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionitemWidget extends StatelessWidget {
  const TransactionitemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSvgIcon(
          path: Assets.svgs.betting,
        ),
        16.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Betting',
                style: context.textTheme.bodyMedium,
              ),
              10.verticalSpace,
              Row(
                children: [
                  Text(
                    'Pending',
                    style: context.textTheme.labelMedium!.copyWith(
                      color: const Color(0xff332F2F),
                    ),
                  ),
                  8.horizontalSpace,
                  Container(
                    width: 2,
                    height: 2,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.black),
                  ),
                  8.horizontalSpace,
                  Text(
                    'Today',
                    style: context.textTheme.labelMedium!.copyWith(
                      color: const Color(0xff332F2F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          'N2000',
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
