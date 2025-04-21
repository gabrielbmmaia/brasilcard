import 'package:brasilcard/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.darkPrimary,
      secondary: AppColors.lightSecondary,
      surface: AppColors.lightPrimary,
      error: Colors.red,
      onPrimary: AppColors.tertiary,
      onSecondary: AppColors.tertiary,
      onSurface: AppColors.lightPrimary,
      onError: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.lightPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightSecondary,
      elevation: 0,
    ),
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
      onPrimary: AppColors.tertiary,
      onSecondary: AppColors.tertiary,
      onSurface: AppColors.darkPrimary,
      onError: AppColors.black,
    ),
    scaffoldBackgroundColor: AppColors.darkPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSecondary,
      elevation: 0,
    ),
  );
}
