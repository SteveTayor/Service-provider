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
  const AddbasicinformationScreen(
      {super.key, this.userAction = UserAction.create});
  final UserAction userAction;

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: userAction.isCreate
            ? 'Add basic information'
            : 'Update account details',
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          if (userAction.isCreate) ...[
            const Text('Rose Owen').withContainer(
              width: context.width,
              color: AppColors.greyD0.withOpacity(0.3),
              padding: context.symmetricPadding(24, 22),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyD0),
            ),
            SizedBox(height: 24.h),
            const Text('roseowen@gmail.com').withContainer(
              width: context.width,
              color: AppColors.greyD0.withOpacity(0.3),
              padding: context.symmetricPadding(24, 22),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyD0),
            ),
          ] else ...[
            const AppTextField(hintText: 'First Name'),
            SizedBox(height: 24.h),
            const AppTextField(hintText: 'Last Name'),
            SizedBox(height: 24.h),
            const AppTextField(hintText: 'Email'),
            SizedBox(height: 24.h),
            const AppTextField(hintText: 'Phone Number'),
          ],
          SizedBox(height: 24.h),
          const AppDropdown(title: 'Gender'),
          SizedBox(height: 24.h),
          const AppTextField(hintText: 'Address'),
          SizedBox(height: 24.h),
          const AppDatetextfield(title: 'Date of birth'),
          SizedBox(height: 24.h),
          BundlegramButton(
            text: '${userAction.isCreate ? 'Submit' : 'Update'} details',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
