import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformItemWidget extends StatelessWidget {
  const PlatformItemWidget({required this.title, required this.icon, required this.onPressed, super.key});
  final String title;
  final String icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            
          width: 52,height: 52,decoration: BoxDecoration(
            shape: BoxShape.circle,
            
            color: const Color(0xffDDB9B4).withOpacity(0.48),
          ),
            child: AppSvgIcon(path: icon),
          ),
          8.verticalSpace,
          Text(title,style: context.textTheme.bodyMedium!.copyWith(color:
           AppColors.white,fontSize: 14.sp,),),
        ],
      ),
    );
  }
}
