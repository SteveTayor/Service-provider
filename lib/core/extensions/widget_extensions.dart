import 'package:flutter/material.dart';

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
