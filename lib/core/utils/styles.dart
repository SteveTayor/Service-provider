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
  });

  factory BundlegramButtonStyle.primary() = BundlegramButtonPrimary;

  factory BundlegramButtonStyle.secondary() = BundlegramButtonSecondary;
  factory BundlegramButtonStyle.outline() = BundlegramButtonOutline;
  final Color background;
  final Color? textColor;
  final Color borderColor;
  final Border? border;
  final TextStyle? textStyle;

  ///Button default values
  static const double buttonDefaultHeight = 60;
  static const double buttonDefaultWidth = double.infinity;
  static const double badgeDefaultHeight = 20;
  static const double badgeDefaultWidth = 46;
  static const double buttonCornerRadius = 6;
  static const double badgeCornerRadius = 100;
  static const double fontSize = 100;
  static const bool buttonIsEnable = true;
  static const bool buttonIsLoading = false;
}

class BundlegramButtonPrimary extends BundlegramButtonStyle {
  BundlegramButtonPrimary()
      : super(
          background: AppColors.primaryColor,
          textColor: Colors.white,
          borderColor: AppColors.primaryColor,
        );
}

class BundlegramButtonSecondary extends BundlegramButtonStyle {
  BundlegramButtonSecondary()
      : super(
          background: AppColors.primaryColor,
          textColor: AppColors.primaryColor,
          borderColor: Colors.transparent,
          textStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontFamily: FontFamily.mabryPro,
          ),
        );
}

class BundlegramButtonOutline extends BundlegramButtonStyle {
  BundlegramButtonOutline()
      : super(
          background: Colors.transparent,
          textColor: AppColors.greyD0,
          borderColor: AppColors.greyD0,
          border: Border.all(width: 1, color: AppColors.greyD0),
          textStyle: TextStyle(
            color: AppColors.grey19,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.mabryPro,
          ),
        );
}
