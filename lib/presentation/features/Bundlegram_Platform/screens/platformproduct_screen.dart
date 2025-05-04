import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/productuserprice_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformproductitem_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformproductScreen extends StatefulWidget {
  const PlatformproductScreen({ this.title, 
  super.key,   this.type,});
  final String? title;
  final PlatformProductType? type;

  @override
  State<PlatformproductScreen> createState() => _PlatformproductScreenState();
}

class _PlatformproductScreenState extends State<PlatformproductScreen> {
  @override
  Widget build(BuildContext context) {
    return   BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: widget.title??'',
        trailing: Text('History',style: context.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),),
      ),
      body:   Column(
        children: [
          const PlatformphonenumberformWidget(),
          // PlatformphonenumberformWidget(),
        if (widget.type==PlatformProductType.userPrice)
const ProductuserpriceWidget()
          else const            Flexible(child: ProductItemGrid()),
        Row(
  children: [
    AppSvgIcon(path: Assets.svgs.balance),
    16.horizontalSpace,
                 Text('Balance (₦20,000)',style: context.textTheme.
                 bodySmall,),
   const Spacer(),
    Row(
      children: [
                        Text('Top-up >',style: context.textTheme.
                 bodySmall!.copyWith(
                  color: AppColors.primaryColor,
                 ),), 
      ],
    ),
  ],
).withContainer(
      color: const Color(0xffEEF3FF),
      padding: context.symmetricPadding(16, 12),
      borderRadius: BorderRadius.circular(6),
    ),
     40.verticalSpace,

BundlegramButton(text: 'Continue', onPressed: (){
  context.showBottomSheet(
    showIcon: false,
    child: TransactionSummary(
    transactionType: 'Data',
    amount: 'N1000.00',
   paymentMethod: 'paymentMethod', beneficiary: 'beneficiary',
    onPay:(){}, ),);
},),
 
        ],
      ),);
  }
}