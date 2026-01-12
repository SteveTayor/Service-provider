import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = _themeData(_lightColorScheme);
  static ThemeData darkTheme = _themeData(_darkColorScheme);

  static ThemeData _themeData(ColorScheme colorScheme) => ThemeData(
        appBarTheme: _appBarTheme(colorScheme),
        brightness: colorScheme.brightness,
        scaffoldBackgroundColor: AppColors.background,
        iconTheme: _iconThemeData(colorScheme),
        colorScheme: colorScheme,
        textTheme: _textTheme(colorScheme),
      );

  static final ColorScheme _lightColorScheme =
      const ColorScheme.light().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.primaryColor,
    onPrimary: AppColors.primaryColor,
    surface: AppColors.white,
    onSurface: AppColors.black,
  );

  static final ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.primaryColor,
    onPrimary: AppColors.primaryColor,
    surface: AppColors.black,
    onSurface: AppColors.white,
  );

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        color: colorScheme.onSurface,
      );

  static IconThemeData _iconThemeData(ColorScheme colorScheme) =>
      IconThemeData(color: colorScheme.onPrimary);

  // Original text theme (using screenutil)
  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        displayLarge: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.grey19,
          fontFamily: FontFamily.robotoBold,
        ),
        displaySmall: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
          fontFamily: FontFamily.robotoSemiBold,
        ),
        labelMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF333333),
          fontFamily: FontFamily.robotoRegular,
        ),
        labelSmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.grey33,
          fontFamily: FontFamily.robotoSemiBold,
        ),
        titleLarge: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.w900,
          color: AppColors.black,
          letterSpacing: 1,
          fontFamily: FontFamily.robotoBold,
        ),
        titleSmall: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontFamily: FontFamily.robotoBold,
        ),
        titleMedium: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
          fontFamily: FontFamily.robotoBold,
        ),
        bodyLarge: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
          fontFamily: FontFamily.robotoSemiBold,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontFamily: FontFamily.robotoSemiBold,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.grey33,
          fontFamily: FontFamily.robotoSemiBold,
        ),
        headlineLarge: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.grey19,
          fontFamily: FontFamily.robotoSemiBold,
        ),
        headlineMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          fontFamily: FontFamily.robotoBold,
        ),
      );

  // NEW: Responsive text theme helper (use in specific screens)
  static TextTheme responsiveTextTheme(BuildContext context) {
    final responsive = context.responsive;
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: responsive.textSize(24),
        fontWeight: FontWeight.w500,
        color: AppColors.grey19,
        fontFamily: FontFamily.robotoBold,
      ),
      displaySmall: TextStyle(
        fontSize: responsive.textSize(14),
        fontWeight: FontWeight.w600,
        color: AppColors.black,
        fontFamily: FontFamily.robotoSemiBold,
      ),
      titleSmall: TextStyle(
        fontSize: responsive.textSize(18),
        fontWeight: FontWeight.w500,
        color: AppColors.black,
        fontFamily: FontFamily.robotoBold,
      ),
      bodyMedium: TextStyle(
        fontSize: responsive.textSize(14),
        fontWeight: FontWeight.w500,
        color: AppColors.black,
        fontFamily: FontFamily.robotoSemiBold,
      ),
      titleMedium: TextStyle(
        fontSize: responsive.textSize(22),
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        fontFamily: FontFamily.robotoBold,
      ),
      bodyLarge: TextStyle(
        fontSize: responsive.textSize(22),
        fontWeight: FontWeight.w600,
        color: AppColors.black,
        fontFamily: FontFamily.robotoSemiBold,
      ),
      headlineLarge: TextStyle(
        fontSize: responsive.textSize(26),
        fontWeight: FontWeight.w500,
        color: AppColors.grey19,
        fontFamily: FontFamily.robotoSemiBold,
      ),
      titleLarge: TextStyle(
        fontSize: responsive.textSize(40),
        fontWeight: FontWeight.w900,
        color: AppColors.black,
        letterSpacing: 1,
        fontFamily: FontFamily.robotoBold,
      ),
      bodySmall: TextStyle(
        fontSize: responsive.textSize(12),
        fontWeight: FontWeight.w400,
        color: AppColors.grey33,
        fontFamily: FontFamily.robotoSemiBold,
      ),
      headlineMedium: TextStyle(
        fontSize: responsive.textSize(14),
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        fontFamily: FontFamily.robotoBold,
      ),
      labelMedium: TextStyle(
        fontSize: responsive.textSize(14),
        fontWeight: FontWeight.w400,
        color: Color(0xFF333333),
        fontFamily: FontFamily.robotoRegular,
      ),
      labelSmall: TextStyle(
        fontSize: responsive.textSize(12),
        fontWeight: FontWeight.w400,
        color: AppColors.grey33,
        fontFamily: FontFamily.robotoSemiBold,
      ),
      headlineSmall: TextStyle(
        fontSize: responsive.textSize(16),
        fontWeight: FontWeight.w500,
        color: AppColors.black,
        fontFamily: FontFamily.robotoSemiBold,
      ),
      labelLarge: TextStyle(
        fontSize: responsive.textSize(20),
        fontWeight: FontWeight.w600,
        color: AppColors.black,
        fontFamily: FontFamily.robotoSemiBold,
      ),
      displayMedium: TextStyle(
        fontSize: responsive.textSize(18),
        fontWeight: FontWeight.w400,
        color: AppColors.grey19,
        fontFamily: FontFamily.robotoRegular,
      ),
      // Add more as needed
    );
  }
}
