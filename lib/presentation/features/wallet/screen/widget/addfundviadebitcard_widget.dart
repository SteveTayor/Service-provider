// ignore_for_file: lines_longer_than_80_chars

import 'package:bundlegram/Core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddfundviadebitcardWidget extends StatefulWidget {
  const AddfundviadebitcardWidget({super.key});

  @override
  State<AddfundviadebitcardWidget> createState() => _AddfundviadebitcardWidgetState();
}

class _AddfundviadebitcardWidgetState extends State<AddfundviadebitcardWidget> {
   
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.symmetricPadding(16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add money via debit card',style: context.textTheme.displaySmall,),
        28.verticalSpace,
        const AppTextField(
          hintText: 'Amount to top-up',
        ),
        40.verticalSpace,
        BundlegramButton(text: 'Continue', onPressed: (){
          context..pop()
          ..push(RouteConstants.topUpResult);
        },),
        20.verticalSpace,
        ],
      ),
    );
  }
}
