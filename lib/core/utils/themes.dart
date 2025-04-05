import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

    ThemeData lightTheme = _themeData(_lightColorScheme);

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
  );

  static final ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.primaryColor,
    onPrimary: AppColors.primaryColor,
    surface: AppColors.black,
  );

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        color: colorScheme.onSurface,
      );

  static IconThemeData _iconThemeData(ColorScheme colorScheme) =>
      IconThemeData(color: colorScheme.onPrimary);

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        titleLarge: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.w900,
          color: AppColors.black,
          letterSpacing: -1.sp,
          fontFamily: FontFamily.mabryProBold,
        ),
        titleSmall: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontFamily: FontFamily.mabryProBold,
        ),
        titleMedium: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
          fontFamily: FontFamily.mabryProBold,
        ),
         bodyLarge: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
          fontFamily: FontFamily.mabryPro,
        ),
          bodyMedium: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontFamily: FontFamily.mabryPro,
        ),
        bodySmall: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
           color: AppColors.black,
          fontFamily: FontFamily.mabryPro,
        ),
       
      );
}
