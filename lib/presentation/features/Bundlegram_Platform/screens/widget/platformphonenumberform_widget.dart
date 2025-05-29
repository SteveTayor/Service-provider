
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/choosebiller.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformphonenumberformWidget extends StatelessWidget {
  const PlatformphonenumberformWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          hintText: 'Phone Number',
          prefixIcon: GestureDetector(
            onTap: (){
               context.showBottomSheet(
        
        child: const ChoosebillerWidget(),);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                16.horizontalSpace,
                Assets.images.mtn.image(),
                AppSvgIcon(path: Assets.svgs.chevronDown),
                8.horizontalSpace,
              ],
            ),
          ),
        ),
        24.verticalSpace,
        const AppDropdown(title: 'SME'),
      ],
    );
  }
}