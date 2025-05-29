import 'package:bundlegram/Core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/statisticvisual.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewStatisticsWidget extends StatelessWidget {
  const ViewStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.showBottomSheet(child: const StatisticsDashboard());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppSvgIcon(path: 
          Assets.svgs.viewstat,
          
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('View statistics',style: context.textTheme.bodyMedium,),
              Text('View charts of your transactions',
              style: context.textTheme.bodySmall!.copyWith(fontSize: 14.sp),),
            ],
          ),
          AppSvgIcon(path: 
          Assets.svgs.chevronDown,
      
          ),
        ],
      ).withContainer(
        color: AppColors.white,
        width: context.width,
       
        boxShadow: [
          const BoxShadow(
              color: Color(0xFFEBEEF1),
              offset: Offset(0, 4),
              blurRadius: 24,
            ),
        ],
        borderRadius: BorderRadius.circular(8.r),
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}