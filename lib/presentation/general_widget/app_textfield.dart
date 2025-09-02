import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.textStyle,
    this.width,
    this.height = 62,
    this.labelSpace = 8,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.decoration,
    this.hintStyle,
    this.backgroundColor,
    this.isLoading = false,
    this.readOnly = false,
    this.customLabel,
    this.hintText,
    this.controller,
    this.minLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.validateFunction,
    this.borderSide,
    this.onSaved,
    this.onChange,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.enableErrorMessage = true,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.bordercolor,
    this.autofocus,
    this.label,
    this.inputFormatters,
    this.borderRadius = 8,
    this.initialValue,
    this.labelSize,
    this.labelColor,
    this.cursorColor,
    this.textAlign,
    this.isFilled = false,
  });
  final double? width;
  final double? height;
  final double? labelSize;
  final String? hintText;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final bool? enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved;
  final void Function(String)? onChange;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? submitAction;
  final bool? enableErrorMessage;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? bordercolor;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? cursorColor;
  final bool? autofocus;
  final String? label;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading;
  final bool readOnly;
  final double borderRadius;
  final double labelSpace;
  final String? initialValue;
  final Widget? customLabel;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final TextAlign? textAlign;
  final TextCapitalization textCapitalization;
  final bool? isFilled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String? error;

  // Helper method to determine the appropriate border color
  Color _getBorderColor() {
    if (widget.bordercolor != null) {
      return widget.bordercolor!;
    }

    // If the field is disabled, use a lighter/muted border color
    if (widget.enabled == false) {
      return AppColors.greyEE; // Much lighter color for disabled state
    }

    // Default active/enabled border color
    return AppColors.greyD0;
  }

  // Helper method to determine background color
  Color _getBackgroundColor() {
    if (widget.backgroundColor != null) {
      return widget.backgroundColor!;
    }

    // If disabled, use a muted background
    if (widget.enabled == false) {
      return AppColors.greyF5; // Light grey background for disabled state
    }

    return AppColors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.width ?? context.width,
          child: TextFormField(
            textCapitalization: widget.textCapitalization,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            initialValue: widget.initialValue,
            textAlign: widget.textAlign ?? TextAlign.start,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autofocus ?? false,
            autovalidateMode: AutovalidateMode.onUnfocus,
            enabled: widget.enabled,
            validator: widget.validateFunction != null
                ? widget.validateFunction!
                : (value) {
                    return null;
                  },
            onSaved: (val) {
              widget.validateFunction != null
                  ? error = widget.validateFunction!(val)
                  : error = null;
              setState(() {});

              if (widget.onSaved != null) widget.onSaved!.call(val!);
            },
            onChanged: (val) {
              widget.validateFunction != null
                  ? error = widget.validateFunction!(val)
                  : error = null;
              setState(() {});
              if (widget.onChange != null) widget.onChange!.call(val);
            },
            style: widget.textStyle ??
                context.textTheme.bodySmall?.copyWith(
                  color: widget.enabled == false
                      ? AppColors.grey80 // Muted text color for disabled state
                      : (widget.cursorColor ?? AppColors.grey19),
                ),
            cursorColor: widget.cursorColor ?? AppColors.grey80,
            key: widget.key,
            maxLines: widget.maxLines,
            controller: widget.controller,
            obscureText: widget.obscureText!,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: widget.decoration ??
                InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  filled: widget.isFilled ??
                      (widget.enabled == false), // Fill disabled fields
                  constraints: BoxConstraints(
                    minHeight: 40.h,
                  ),
                  fillColor: _getBackgroundColor(),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40.w,
                    minHeight: 18.h,
                  ),
                  prefixIcon: widget.prefixIcon,
                  suffixIconConstraints:
                      BoxConstraints(minWidth: 50.w, minHeight: 18.h),
                  suffixIcon: widget.suffixIcon,
                  errorStyle: context.textTheme.bodySmall!.copyWith(
                    fontSize: 0,
                    color: AppColors.errorText,
                  ),
                  hintText: widget.hintText,
                  errorMaxLines: 1,
                  hintStyle: widget.hintStyle ??
                      context.textTheme.bodySmall!.copyWith(
                        color: widget.enabled == false
                            ? AppColors
                                .greyb3 // Lighter hint text for disabled state
                            : AppColors.grey33,
                      ),
                  // Enabled border (when field is enabled but not focused)
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: BorderSide(
                      color: _getBorderColor(),
                    ),
                  ),
                  // Focused border (when field is enabled and focused)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: BorderSide(
                      color: widget.enabled == false
                          ? _getBorderColor() // Keep same border color if disabled
                          : (widget.bordercolor ??
                              AppColors.greyD0), // Normal focus color
                      width: widget.enabled == false
                          ? 1.0
                          : 1.5, // Thicker border when focused and enabled
                    ),
                  ),
                  // Disabled border (when field is disabled)
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: BorderSide(
                      color: AppColors
                          .greyEE, // Very light border for disabled state
                    ),
                  ),
                  // Default border
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: BorderSide(
                      color: _getBorderColor(),
                    ),
                  ),
                ),
          ),
        ),
        if (error != null)
          SizedBox(
            height: 5.h,
          ),
        if (error != null)
          Text(
            error!,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.errorText,
            ),
          ),
      ],
    );
  }
}
