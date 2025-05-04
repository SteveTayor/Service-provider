import 'package:bundlegram/Core/extensions/context_extensions.dart';
import 'package:bundlegram/Core/utils/colors.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatFormDrawer extends StatelessWidget {
  const PlatFormDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      child: SizedBox(
        width: 300.w,
        child: Column(
         
          children: [
              Column(
        mainAxisAlignment:MainAxisAlignment.end ,
        children: [
          Row(
        children: [
          Text('Hi Emmanuel',style: context.textTheme.headlineMedium,),
          8.horizontalSpace,
          AppSvgIcon(path: Assets.svgs.warrantyBadgeHighlightStreamlineFlex),
        ],
          ),
          12.verticalSpace,
        Row(
        children: [
          AppSvgIcon(path: Assets.svgs.crownStreamlineFlex),
          6.horizontalSpace,
          Text('Bundlegram agent',style: context.textTheme.bodySmall!.copyWith(
            fontSize: 14.sp,
          ),),
        ],
          ),
        ],
            ).withContainer(
              height: 152.h,
              padding: EdgeInsets.only(
                left: 20.w,
                bottom: 20.h,),
              color: AppColors.primaryColor,
            ),
            14.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(PlatFormData.platformDrawerItem.length,
               (index){
                return PlatFormData.platformDrawerItem[index].withContainer(
                  padding: context.symmetricPadding(0, 18.h),
                  margin: context.symmetricPadding(20.w, 10.h),
                );
               }),
            ),
          ],
        ),
      ),
    );
  }
}