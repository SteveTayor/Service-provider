import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_datetextfield.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddbasicinformationScreen extends StatelessWidget {
  const AddbasicinformationScreen({super.key,this.userAction = UserAction.create});
  final UserAction userAction;
  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar:   BundlegramAppbar(titleText:
      userAction.isCreate?
       'Add basic information':'Update account details',),
      body: Column(
        children: [
       if (userAction.isCreate) Column(
            children: [
              const Text('Rose Owen').withContainer(
                      width: context.width,
                      color: AppColors.greyD0.withOpacity(0.3),
               padding: context.symmetricPadding(24, 22),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.greyD0),
                     ),
                     24.verticalSpace,
              const Text('roseowen@gmail.com').withContainer(
                      width: context.width,
                      color: AppColors.greyD0.withOpacity(0.3),
               padding: context.symmetricPadding(24, 22),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.greyD0),
                     ),
            ],
          ) else   Column(
            children: [
              const AppTextField(
                hintText: 'First Name',
              ),
              24.verticalSpace,
                            const AppTextField(
                hintText: 'Last Name',
              ),
              24.verticalSpace,
                            const AppTextField(
                hintText: 'Email',
              ),
              24.verticalSpace,
                            const AppTextField(
                hintText: 'Phone Number',
              ),
            ],
          ),
       
       24.verticalSpace,
       
       const AppDropdown(title: 'Gender'),
       24.verticalSpace,
      
       const AppTextField(hintText: 'Address',),
       24.verticalSpace,
 const AppDatetextfield(title: 'Date of birth'),
       24.verticalSpace,
       BundlegramButton(text:
       
        '${userAction.isCreate?'Submit':'Update'} details',
        onPressed: (){},),
        ],
      )
    
    ,);
  }
}