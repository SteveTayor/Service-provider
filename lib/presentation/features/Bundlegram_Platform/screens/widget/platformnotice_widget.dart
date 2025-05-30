import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformNoticeWidget extends StatefulWidget {
  const PlatformNoticeWidget({super.key});

  @override
  State<PlatformNoticeWidget> createState() => _PlatformNoticeWidgetState();
}

class _PlatformNoticeWidgetState extends State<PlatformNoticeWidget> {
  int indexKey = 0;
  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        CarouselSlider(
   items: List.generate(3, (index){
    return AppSvgIcon(
      onTap: PlatFormData.advertFunction(context)[index],
              fit: BoxFit.scaleDown,
              path: PlatFormData.advert[index],);
   }),
   options: CarouselOptions(
      autoPlay: true,
      padEnds:false ,
      onPageChanged: (c,x){
setState(() {
  indexKey =c;
});
      },
      autoPlayInterval: const Duration(seconds: 3),
      enlargeCenterPage: true,
   ),),
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(3, (index)=>Container(
      width: indexKey ==index?20.w:6.w,height: 6.h,
      margin: context.symmetricPadding(4, 0),
      decoration: BoxDecoration(
        color: indexKey==index?AppColors.primaryColor:AppColors.greyb3,
        borderRadius: BorderRadius.circular(8.r),
      ),
    ),),
   ),
        // Container(
        //   height: 189.h,
        //   padding: const EdgeInsets.only(left: 16),
        //   child:   CarouselView.weighted(
         
             
        //     flexWeights: const [3,2,1],
            
        //     children: List.generate(PlatFormAdvertData.advert.length,
          
        //      (index)=>AppSvgIcon(
         
        //       fit: BoxFit.scaleDown,
        //       path: PlatFormAdvertData.advert[index],).withContainer(margin: const EdgeInsets.only(right: 16)),),
        //   ),
        // ),
      ],
    );
  }
}

