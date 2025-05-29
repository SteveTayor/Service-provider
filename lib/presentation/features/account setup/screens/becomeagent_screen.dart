import 'package:bundlegram/Core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/verifyemail_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class BecomeagentScreen extends StatelessWidget {
  const BecomeagentScreen({super.key});

  @override
  Widget build(BuildContext context) {
     
      Widget buildItemRow(
         
        String asset,String title, String label,  
        {VoidCallback? onPressed,}){
      return 
      InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
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
 
          ],
        ).withContainer(
          padding: context.symmetricPadding(0, 8),
          margin: EdgeInsets.only(bottom: 24.h),
        ),
      );
    
    }
   
    return   BundlegramScaffold(
      appBar: const BundlegramAppbar(titleText: 'Become an agent',),
      body: SingleChildScrollView(
        child: Column(
        
         children: [
          Text('What’s in it for you?',
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium!.copyWith(
            color: AppColors.grey33,
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
          ),
         24.verticalSpace,
         
         Column(
          
          children: [
            buildItemRow(Assets.svgs.union,
           
             'Easy Onboarding Process', 'No need to fill out forms or go through a verification process. Create an account instantly to start reselling airtime and data.',
             ),
            buildItemRow(Assets.svgs.box,
           
             'Discounts and Withdrawals', 'Enjoy discounts on every data top-up and airtime top-up of all networks, with an instant settlement of all agent withdrawal transactions.',
             ),
            buildItemRow(Assets.svgs.chartBarSquare,
             'Monitor Your Business',
        'Our in-depth dashboards and advanced analytics offer complete visibility over every single aspect of your daily transactions, leaving no room for ambiguity.',
             ),
            buildItemRow(Assets.svgs.call,
             '24/7 Customer Support',
        'Bundlegram provides 24/7 customer support to ensure success. Our support channels are always available to assist you.',
             ),
            buildItemRow(Assets.svgs.banknotes,
             'Earn More Money',
        'Become a Bundlegram agent and start making money on every transaction you make. With our low pricing, you can make money daily.',
             ),
            buildItemRow(Assets.svgs.noapineeded,
             'No API Required',
        'It’s easy to become a Bundlegram agent - just create an account, complete KYC, and start selling airtime and data to your customers.',
             ),
        40.verticalSpace,
        BundlegramButton(text: 'Continue', onPressed: (){
          context.showBottomSheet(child: TransactionSummary(amount: 'N10000',
           paymentMethod: 'Wallet', beneficiary: '', onPay: (){},),);
        },),
            
          ],
         ),
         ],
        
        
        ),
      )
    
    ,);
  }
}