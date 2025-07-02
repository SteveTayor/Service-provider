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

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        displayLarge: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.grey19,
          fontFamily: FontFamily.mabryProBold,
        ),
        displaySmall: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
          fontFamily: FontFamily.mabryPro,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.grey33,
          fontFamily: FontFamily.mabryPro,
        ),
        titleLarge: TextStyle(
          fontSize: 38.sp,
          fontWeight: FontWeight.w900,
          color: AppColors.black,
          letterSpacing: -1.sp,
          fontFamily: FontFamily.mabryProBold,
        ),
        titleSmall: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontFamily: FontFamily.mabryProBold,
        ),
        titleMedium: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
          fontFamily: FontFamily.mabryProBold,
        ),
        bodyLarge: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
          fontFamily: FontFamily.mabryPro,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontFamily: FontFamily.mabryPro,
        ),
        bodySmall: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.grey33,
          fontFamily: FontFamily.mabryPro,
        ),
        headlineLarge: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.grey19,
          fontFamily: FontFamily.mabryPro,
        ),
        headlineMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          fontFamily: FontFamily.mabryProBold,
        ),
      );
}
