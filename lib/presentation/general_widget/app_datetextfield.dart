import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef StringValidator = String? Function(String?);

class AppDatetextfield extends StatelessWidget {
  const AppDatetextfield({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.validator,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final StringValidator? validator;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.bodySmall),
        8.verticalSpace,
        GestureDetector(
          onTap: readOnly && onTap != null ? onTap : null,
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            onTap: !readOnly ? onTap : null,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: context.textTheme.bodySmall!
                  .copyWith(color: AppColors.grey33),
              filled: true,
              fillColor: AppColors.white,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: AppSvgIcon(path: Assets.svgs.calendar),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: AppColors.greyD0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: AppColors.greyD0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: AppColors.errorText),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
