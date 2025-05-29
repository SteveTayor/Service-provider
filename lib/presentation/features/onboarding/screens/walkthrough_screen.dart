
import 'package:bundlegram/Presentation/Features/Onboarding/Notifier/onboard_notifier.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/app_router.dart';
import 'package:bundlegram/core/router/route_constants.dart';
// import 'package:bundlegram/core/router/router.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/onboarding_data.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';



 class WalkthroughScreen extends StatelessWidget {
   const WalkthroughScreen({super.key});
 
   @override
 Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ref,__) {
    final notifier = ref.read(onboardingNotifierProvider.notifier);
        final walkthroughIndex = ref
        .watch(onboardingNotifierProvider.select((v) => v.walkThroughIndex));
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                 children: [
                  50.verticalSpace,
                   Expanded(
               child: PageView(
                onPageChanged: notifier.updateWalkThroughIndex,
                children: List.generate(OnboardingData.walkthrough.length,
                 (index){
                  return Column(
                    children: [
                             Text(OnboardingData.walkthrough[index]['name']!
                             .toUpperCase(),
                             textAlign: TextAlign.center,
                             style: context.textTheme.titleLarge,
                        
                             ),
                             Text(OnboardingData.walkthrough[index]['subText']!,
                             style:  context.textTheme.bodySmall,
                             ),
                             
                             Expanded(
                               child: Center(
                                child:   AssetGenImage(OnboardingData.walkthrough[index]['icon']!).image(),),
                             ),
                        
                    ],
                  );
                 }),
               ),
                   ),
               30.verticalSpace,
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index){
                return Container(
                  margin:  EdgeInsets.symmetric(horizontal: 6.h),
                  width: walkthroughIndex ==index?20.w:6.w,height: 6.h,
                  decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              color:index==walkthroughIndex?
              Colors.black:
               const Color(0xffB3B3B3),
                  ),
                );
              }),
                   ),
                   30.verticalSpace,
                   BundlegramButton(text: 'Create account',
                    onPressed: ()=>context.go(
                      RouteConstants.register,),),
              34.verticalSpace,
              InkWell(
                onTap: (){
                  context.push(RouteConstants.login);
                },
                child: Text('I already have an account',
                style: context.textTheme.bodyMedium,
                ),
              ),
                 ],
              ),
            ),
          ),
        );
      },
    );
  }

 }
