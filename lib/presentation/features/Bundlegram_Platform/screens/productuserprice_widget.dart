import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductuserpriceWidget extends StatelessWidget {
  const ProductuserpriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        24.verticalSpace,
        const AppDropdown(title: 'Startimes Plus Web Access'),
        24.verticalSpace,
const AppTextField(hintText: 'N',),
        24.verticalSpace,
      ],
    );
  }
}