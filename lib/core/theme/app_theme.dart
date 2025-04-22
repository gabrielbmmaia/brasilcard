import 'package:brasilcard/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      surface: AppColors.lightPrimary,
      error: Colors.red,
      tertiary: AppColors.tertiary,
      onPrimary: AppColors.black,
      onSecondary: AppColors.black,
      onSurface: AppColors.black38,
    ),
    scaffoldBackgroundColor: AppColors.lightPrimary,
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      surface: AppColors.darkPrimary,
      tertiary: AppColors.tertiary,
      error: Colors.red,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.white30,
    ),
    scaffoldBackgroundColor: AppColors.darkPrimary,
  );
}
