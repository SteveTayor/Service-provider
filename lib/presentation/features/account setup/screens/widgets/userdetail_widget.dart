import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserdetailWidget extends StatelessWidget {
  const UserdetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
      Row textWithIcon(String assetName, String title){
  return   Row(
    children: [
      AppSvgIcon(path: assetName),
      6.horizontalSpace,
      Text(title,style: context.textTheme.labelMedium),
    ],
  );
}

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AA',style: context.textTheme.titleMedium!.copyWith(
              color: AppColors.white,
            ),).withContainer(
          color: AppColors.pink,
          width: 64,height: 64,
          alignment: Alignment.center,
          shape: BoxShape.circle,
        ),
        12.verticalSpace,
  Text('Adeboye Adeyemi',style: context.textTheme.titleMedium),
textWithIcon( Assets.svgs.infoCircle1, 'Verification incomplete'),
8.verticalSpace,
textWithIcon( Assets.svgs.crownRewardSocialRatingMediaQueenVipKingCrown, 'Bundlegram agent'),
14.verticalSpace,
  InkWell(
    onTap: (){
      context.push(RouteConstants.accountSetup);
    },
    child: Text('Complete account set up',style: context.textTheme.bodySmall!.copyWith(
      decoration: TextDecoration.underline,
      decorationColor: AppColors.black,
    ),
    ),
  ),
          ],
        ),
       AppSvgIcon(
        onTap: (){
          context.push(RouteConstants.setting);
        },
        path: Assets.svgs.cogStreamlineCore,),
      ],
    );
  }
}
