import 'package:bundlegram/Core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/verifyemail_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class AccountsetupScreen extends StatelessWidget {
  const AccountsetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
     
      Widget buildItemRow(
         
        String asset,String title, String label, bool verify,
        {VoidCallback? onPressed,}){
      return 
      InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSvgIcon(path: asset),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: context.textTheme.bodyMedium,),
                  8.verticalSpace,
                  Text(label,style: context.textTheme.labelMedium,),
                ],
              ),
            ),
                      AppSvgIcon(path:verify? Assets.svgs.check:Assets.svgs.unveirifycheck),
          ],
        ).withContainer(
          padding: context.symmetricPadding(0, 8),
          margin: EdgeInsets.only(bottom: 24.h),
        ),
      );
    
    }
   
    return   BundlegramScaffold(
      appBar: const BundlegramAppbar(titleText: 'Complete account set up',),
      body: Column(

 children: [
  Text('Hi Rose, finish setting up your account to enjoy Bundlegram fully.',
  textAlign: TextAlign.center,
  style: context.textTheme.bodyMedium!.copyWith(
    color: AppColors.grey33,
  ),
  ),
 24.verticalSpace,
 SizedBox(
  height: 10.h,
   child: Row(
    children: List.generate(5, (index){
      return Expanded(child: 
      Container(
        height: 10.h,
        margin:context.symmetricPadding(4, 0) ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color:
          index ==0?
           AppColors.primaryColor:AppColors.greyd9,
        ),
      ),
      );
    }),
   ),
 ),
 48.verticalSpace,
 Column(
  
  children: [
    buildItemRow(Assets.svgs.createaccount,
   
     'Create account', 'Create a Bundlegram account',
     true,),
    buildItemRow(
       onPressed: () => context.showBottomSheet(child: const VerifyemailWidget()),
      Assets.svgs.verifyemail,
     'Verify email', 'Verify your email for security purpose',
     false,),
    buildItemRow(
      onPressed: ()=>context.push(RouteConstants.addbasicinformation),
      Assets.svgs.addbasicinfo,
     'Add basic information',
      'Let’s know more about you',
     false,),
    buildItemRow(
      onPressed: ()=>context.push(RouteConstants.linkyourbvn),
      Assets.svgs.linkyourbvn,
     'Link your BVN',
      'Link BVN to be able to withdraw',
     false,),
    buildItemRow(
        onPressed: ()=>context.push(RouteConstants.addbankdetail),
      Assets.svgs.addbankdetail,
     'Add bank details',
      'Save bank details to withdraw later',
     false,),
  ],
 ),
 ],


      )
    
    ,);
  }
}