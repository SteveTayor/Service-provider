import 'package:bundlegram/Core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension WidgetExtension on Widget {
  Widget withContainer({
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxShape shape = BoxShape.rectangle,
    Color? color,
    BoxBorder? border,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    List<BoxShadow>? boxShadow,
  }) {
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        border: border,
        color: color,
        shape: shape,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: this,
    );
  }

  Widget withLoadingWidget({
    required bool isLoading,
    double height = 30,
    double width = 100,
    Color? color,
    EdgeInsetsGeometry? margin,
    Widget? loadingWidget,
  }) {
    return isLoading
        ? loadingWidget ??
            Container(
              margin: margin,
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: color ?? Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            )
        : this;
  }

  Widget withLoadingList({
    required bool isLoading,
    double height = 200,
    int length = 10,
  }) {
    return isLoading
        ? ListView.separated(
            key: const ValueKey('loading'),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (context, index) {
              return Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  height: height,
                  width: MediaQuery.sizeOf(context).width,);
            },
          )
        : this;
  }
}


extension AppTextFieldDecorationExtension on InputDecoration{
InputDecoration  search(){
    return InputDecoration(
      fillColor: const Color(0xffEEEEEC),
      filled: true,
    prefixIcon: const Icon(Icons.search,color: AppColors.black,),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 14.sp,color: AppColors.grey8E,),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        // gapPadding: 14,
borderRadius: BorderRadius.circular(80.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        
borderRadius: BorderRadius.circular(80.r),
      ),
    ) ;
  }
InputDecoration  disable(){
    return InputDecoration(
      fillColor: AppColors.greyD0.withOpacity(0.3),
      filled: true,
     
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.black,),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.greyD0),
        // gapPadding: 14,
borderRadius: BorderRadius.circular(6.r),
      ),
      enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.greyD0),
        
        
borderRadius: BorderRadius.circular(6.r),
      ),
    ) ;
  }
}