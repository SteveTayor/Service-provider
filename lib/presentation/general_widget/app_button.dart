// ignore_for_file: lines_longer_than_80_chars, use_if_null_to_convert_nulls_to_bools, avoid_bool_literals_in_conditional_expressions

import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom Bundle button. This was built to adapt to the our in-house button style.
/// Works similarly to default flutter button except for its aesthetic changes.
/// It currently support various BundlegramButtonStyles
/// [BundlegramButtonStyle.primary],
/// [BundlegramButtonStyle.secondary],
/// which primarily decides the background and foreground colors of the buttons only.
/// Its represented by various states such as *isEnabled* which alters the state of the button
/// view and also disable it click action, similar to the *isLoading* which enables the loading view of the button.
/// ### Params
/// * [text] - represents the text to show in the button
/// * [height] - default button height
/// * [width] - default button width
/// * [isEnabled] - determines whether button should be clickable, invoke callback or not. Can also be use to modify
/// how button view reacts to click events and UI changes.
/// * [isLoading] - determines whether button should show loading state or not
/// * [buttonStyle] - can be use to determine the style applied to button as mentioned above
/// * [onPressed] - a simple callback that gets triggered when button is pressed

class BundlegramButton extends StatefulWidget {
  const BundlegramButton({
    required this.text,
    required this.onPressed,
    this.height = BundlegramButtonStyle.buttonDefaultHeight,
    this.width = BundlegramButtonStyle.buttonDefaultWidth,
    this.isLoading = BundlegramButtonStyle.buttonIsLoading,
    this.isEnabled = BundlegramButtonStyle.buttonIsEnable,
    this.cornerRadius = BundlegramButtonStyle.buttonCornerRadius,
    this.buttonStyle,
    this.leading,
    this.trailing,
    this.textStyle,
    this.color,
    this.svgIconContainerColor,
    this.borderColor,
    this.isOutline,
    this.useResponsive = true,
    super.key,
  });

  final String text;
  final double height;
  final double width;
  final double cornerRadius;
  final bool isEnabled;
  final bool isLoading;
  final bool? isOutline;
  final Color? color;
  final Color? borderColor;
  final BundlegramButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final Color? svgIconContainerColor;
  final VoidCallback? onPressed;
  final String? leading;
  final String? trailing;
  final bool useResponsive;

  @override
  State<BundlegramButton> createState() => _BundlegramButton();
}

class _BundlegramButton extends State<BundlegramButton> {
  bool isClicked = false;
  late BundlegramButtonStyle _buttonStyle;

  @override
  void initState() {
    _buttonStyle = widget.buttonStyle ?? BundlegramButtonStyle.primary();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BundlegramButton oldWidget) {
    _buttonStyle = widget.buttonStyle ?? BundlegramButtonStyle.primary();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    // Calculate responsive sizes
    final effectiveHeight = widget.useResponsive
        ? responsive.spacing(widget.height)
        : widget.height;
    final effectiveCornerRadius = widget.useResponsive
        ? responsive.radiusSize(widget.cornerRadius)
        : widget.cornerRadius;

    // NEW: Get responsive font size from style's baseFontSize
    final baseFontSize =
        _buttonStyle.baseFontSize ?? BundlegramButtonStyle.defaultFontSize;
    final responsiveFontSize =
        widget.useResponsive ? responsive.textSize(baseFontSize) : baseFontSize;

    return GestureDetector(
      onTap: isActive() ? widget.onPressed : null,
      child: Container(
        alignment: Alignment.center,
        height: effectiveHeight,
        width: widget.width,
        decoration: BoxDecoration(
          border: (widget.isOutline == true)
              ? BundlegramButtonStyle.outline().border
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(effectiveCornerRadius),
          color: widget.isEnabled == false
              ? AppColors.greyD0.withOpacity(0.3)
              : widget.color ?? _buttonStyle.background,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!widget.isLoading)
              FittedBox(
                child: Row(
                  children: [
                    if (widget.leading != null) ...[
                      AppSvgIcon(
                        path: widget.leading!,
                        fit: BoxFit.scaleDown,
                      ).withContainer(
                        width: widget.useResponsive
                            ? responsive.iconSize(base: 32)
                            : 32.w,
                        height: widget.useResponsive
                            ? responsive.iconSize(base: 32)
                            : 32.h,
                        color: widget.svgIconContainerColor ?? AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.86,
                          color: widget.isEnabled == false
                              ? AppColors.greyD0.withOpacity(0.3)
                              : AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width:
                            widget.useResponsive ? responsive.spacing(5) : 5.w,
                      ),
                    ],
                    Text(
                      widget.text,
                      style: widget.textStyle ??
                          _buttonStyle.textStyle?.copyWith(
                            fontSize:
                                responsiveFontSize, // CHANGED: Use responsive size
                            color: widget.isEnabled == false
                                ? AppColors.grey8E
                                : _buttonStyle.textColor,
                          ) ??
                          TextStyle(
                            color: widget.isEnabled == false
                                ? AppColors.grey8E
                                : _buttonStyle.textColor,
                            fontFamily: FontFamily.mabryPro,
                            fontSize:
                                responsiveFontSize, // CHANGED: Use responsive size
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    if (widget.trailing != null) ...[
                      SizedBox(
                        width: widget.useResponsive
                            ? responsive.spacing(10)
                            : 10.w,
                      ),
                      AppSvgIcon(
                        path: widget.trailing!,
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ],
                ),
              ),
            if (widget.isLoading) ...[
              const CircularProgressIndicator.adaptive(),
            ],
          ],
        ),
      ),
    );
  }

  bool isActive() => widget.isEnabled
      ? widget.isLoading
          ? false
          : true
      : false;
}
