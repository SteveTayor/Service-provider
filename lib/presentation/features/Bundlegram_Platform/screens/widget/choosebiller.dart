import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoosebillerWidget extends StatelessWidget {
  const ChoosebillerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.symmetricPadding(20, 0),
          child: AppTextField(
            hintText: 'Search for biller',
            decoration: const InputDecoration().search(),
          ),
        ),
        30.verticalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(PlatFormData.payBillWidget.length, (index) {
            return PlatFormData.payBillWidget[index].withContainer(
              padding: context.symmetricPadding(0, 20.h),
              margin: context.symmetricPadding(20.w, 8.h),
            );
          }),
        ),
      ],
    );
  }
}
