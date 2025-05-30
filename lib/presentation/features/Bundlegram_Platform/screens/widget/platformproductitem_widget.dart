import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 

class ProductItemGrid extends StatefulWidget {

  const ProductItemGrid({
    super.key,
    this.onBundleSelected,
    this.showContinueButton = false,
  });
  final Function(Map<String, String>)? onBundleSelected;
  final bool showContinueButton;

  @override
  State<ProductItemGrid> createState() => _ProductItemGridState();
}

class _ProductItemGridState extends State<ProductItemGrid> {
  int? _selectedIndex;

  final List<Map<String, String>> _bundles = [
    {'data': '100MB', 'duration': '1 Day'},
    {'data': '200MB', 'duration': '3 Days'},
    {'data': '1GB', 'duration': '1 Day'},
    {'data': '2.5GB', 'duration': '2 Days'},
    {'data': '5GB', 'duration': '7 Days'},
    {'data': '3GB', 'duration': '30 Days'},
  ];

  Widget _buildBundleOption(Map<String, String> bundle, int index) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        widget.onBundleSelected?.call(bundle);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.grey83.withOpacity(0.2),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.r),
          color:const Color(0xffEEF3FF),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bundle['data']!,
              style: context.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryColor : AppColors.grey83,
              ),
            ),
            4.verticalSpace,
            Text(
              bundle['duration']!,
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.grey83,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.verticalSpace,
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
         padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: 1.2,
            ),
            itemCount: _bundles.length,
            itemBuilder: (context, index) => _buildBundleOption(_bundles[index], index),
          ),
        ),
       24.verticalSpace,
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('Amount',style: context.textTheme.bodySmall,),
               Text('N100',style:
                context.textTheme.bodySmall!.copyWith(color: AppColors.grey19,),),
           ],
         ).withContainer(
        width: context.width,
 
        color: AppColors.greyD0.withOpacity(0.3),
 padding: context.symmetricPadding(12, 12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.greyD0),
       ),
       24.verticalSpace,

      ],
    );
  }
}
