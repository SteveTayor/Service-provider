import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductuserpriceWidget extends StatelessWidget {
  final PlatformProductType serviceType;
  const ProductuserpriceWidget({super.key, required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 24.verticalSpace,
        if (serviceType == PlatformProductType.cableTv) ...[
          const AppDropdown(title: 'Startimes Plus Web Access'),
          24.verticalSpace,
        ]
        // const AppTextField(
        //   hintText: 'N',
        // ),
      ],
    );
  }
}
