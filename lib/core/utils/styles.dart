import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BundlegramButtonStyle {
  BundlegramButtonStyle({
    required this.background,
    required this.borderColor,
    this.textColor = Colors.white,
    this.textStyle,
    this.border,
    this.baseFontSize, // NEW: Base font size for responsive scaling
  });

  factory BundlegramButtonStyle.primary({double? baseFontSize}) =
      BundlegramButtonPrimary;

  factory BundlegramButtonStyle.secondary({double? baseFontSize}) =
      BundlegramButtonSecondary;

  factory BundlegramButtonStyle.outline({double? baseFontSize}) =
      BundlegramButtonOutline;

  final Color background;
  final Color? textColor;
  final Color borderColor;
  final Border? border;
  final TextStyle? textStyle;
  final double? baseFontSize; // NEW

  /// Button default values
  static const double buttonDefaultHeight = 60;
  static const double buttonDefaultWidth = double.infinity;
  static const double badgeDefaultHeight = 20;
  static const double badgeDefaultWidth = 46;
  static const double buttonCornerRadius = 6;
  static const double badgeCornerRadius = 100;
  static const double defaultFontSize = 18; // NEW: Default font size
  static const bool buttonIsEnable = true;
  static const bool buttonIsLoading = false;

  // NEW: Create a responsive version of this style
  BundlegramButtonStyle withResponsiveSize(double scaledFontSize) {
    return BundlegramButtonStyle(
      background: background,
      borderColor: borderColor,
      textColor: textColor,
      border: border,
      baseFontSize: baseFontSize,
      textStyle: textStyle?.copyWith(fontSize: scaledFontSize),
    );
  }
}

class BundlegramButtonPrimary extends BundlegramButtonStyle {
  BundlegramButtonPrimary({double? baseFontSize})
      : super(
          background: AppColors.primaryColor,
          textColor: Colors.white,
          borderColor: AppColors.primaryColor,
          baseFontSize: baseFontSize ?? 18, // Default to 18
        );
}

class BundlegramButtonSecondary extends BundlegramButtonStyle {
  BundlegramButtonSecondary({double? baseFontSize})
      : super(
          background: AppColors.primaryColor,
          textColor: AppColors.primaryColor,
          borderColor: Colors.transparent,
          baseFontSize: baseFontSize ?? 16, // Default to 16
          textStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: baseFontSize ?? 16, // Use parameter or default
            fontFamily: FontFamily.mabryPro,
          ),
        );
}

class BundlegramButtonOutline extends BundlegramButtonStyle {
  BundlegramButtonOutline({double? baseFontSize})
      : super(
          background: Colors.transparent,
          textColor: AppColors.greyD0,
          borderColor: AppColors.greyD0,
          border: Border.all(width: 1, color: AppColors.greyD0),
          baseFontSize: baseFontSize ?? 18, // Default to 18
          textStyle: TextStyle(
            color: AppColors.grey19,
            fontSize: baseFontSize ?? 18, // Use parameter or default
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.mabryPro,
          ),
        );
}
