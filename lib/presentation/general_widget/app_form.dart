// ignore_for_file: prefer_asserts_with_message

import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppForm extends StatefulWidget {
  const AppForm({
    required this.children,
    required this.isActive,
    required this.formKey,
    required this.onPressed,
    required this.buttonText,
    this.isExpanded = true,
    this.extraWidget,
    this.buttonColor,
    this.useResponsive = true, // NEW
    super.key,
  });

  final List<AppTextField> children;
  final VoidCallback onPressed;
  final String buttonText;
  final bool isActive;
  final Widget? extraWidget;
  final bool? isExpanded;
  final Color? buttonColor;
  final GlobalKey<FormState> formKey;
  final bool useResponsive; // NEW

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Form(
      key: widget.formKey,
      child: widget.isExpanded!
          ? SingleChildScrollView(
              child: Column(
                children: [
                  // Form fields
                  ...List.generate(widget.children.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: widget.useResponsive
                            ? responsive.spacing(14)
                            : 14.h,
                      ),
                      child: widget.children[index],
                    );
                  }),

                  // Extra widget if provided
                  if (widget.extraWidget != null) widget.extraWidget!,

                  // Spacing before button
                  SizedBox(
                      height:
                          widget.useResponsive ? responsive.spacing(32) : 32.h),

                  // Button
                  Opacity(
                    opacity: widget.isActive ? 1 : 0.5,
                    child: BundlegramButton(
                      color: widget.buttonColor ?? AppColors.primaryColor,
                      text: widget.buttonText,
                      useResponsive: widget.useResponsive,
                      onPressed: () {
                        widget.onPressed();
                        widget.formKey.currentState!.validate();
                      },
                    ),
                  ),

                  // Bottom padding
                  SizedBox(
                      height:
                          widget.useResponsive ? responsive.spacing(20) : 20.h),
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(widget.children.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          widget.useResponsive ? responsive.spacing(14) : 14.h,
                    ),
                    child: widget.children[index],
                  );
                }),
                widget.extraWidget ?? const SizedBox(),
                SizedBox(
                    height:
                        widget.useResponsive ? responsive.spacing(32) : 32.h),
                Opacity(
                  opacity: widget.isActive ? 1 : 0.5,
                  child: BundlegramButton(
                    color: widget.buttonColor ?? AppColors.primaryColor,
                    text: widget.buttonText,
                    useResponsive: widget.useResponsive,
                    onPressed: () {
                      widget.onPressed();
                      widget.formKey.currentState!.validate();
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
