import 'package:bundlegram/Core/utils/colors.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppListTile extends StatelessWidget {
  const AppListTile({required this.assetPath,required this.title, 
  this.trailingAsset,
  this.onPressed, this.titleColor,super.key,});
  final String assetPath;
  final String? trailingAsset;
  final Color? titleColor;
    final VoidCallback? onPressed;
  final String title;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppSvgIcon(path: assetPath,fit: BoxFit.scaleDown,),
              16.horizontalSpace,
              Text(title,style: context.textTheme.bodyMedium!.copyWith(
                color: titleColor??AppColors.black,
              ),),
            ],
          ),
          
        if (trailingAsset==null) const SizedBox() 
        else AppSvgIcon(path: trailingAsset!,fit: BoxFit.scaleDown,)
                  
                  ,
        ],
      ),
    );
  }
}
