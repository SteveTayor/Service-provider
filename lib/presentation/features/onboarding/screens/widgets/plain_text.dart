import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PlainTextWidget extends StatelessWidget {
  const PlainTextWidget({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          Text(text,style: context.textTheme.bodySmall!.copyWith(
          color: AppColors.grey33,
          height: 30/18,
          ),),
          40.verticalSpace,
          BundlegramButton(text: 'Close', onPressed: ()=>context.pop()),
        ],
      ),
    );
  }
}
