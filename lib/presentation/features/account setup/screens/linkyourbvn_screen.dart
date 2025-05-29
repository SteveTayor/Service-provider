import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinkyourbvnScreen extends StatelessWidget {
  const LinkyourbvnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   BundlegramScaffold(
      appBar: const BundlegramAppbar(titleText: 'Link your BVN',),
      body: 
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTextField(hintText: 'Bank Verification Number (BVN)',),
          24.verticalSpace,
          const AppTextField(hintText: 'Phone Number linked to BVN',),
          24.verticalSpace,
          const AppTextField(hintText: 'Date of birth (DD/MM/YY)',),
          24.verticalSpace,
          const Text('Add bank details of a linked account'),
          18.verticalSpace,
          const AppDropdown(title: 'Bank name'),
          24.verticalSpace,
          const AppTextField(hintText: 'Account number',),
          24.verticalSpace,
          const AppTextField(hintText: 'Account name',),
          40.verticalSpace,
          BundlegramButton(text: 'Submit detail', onPressed: (){}),
        ],
      ),
    )
    ,);
  }
}