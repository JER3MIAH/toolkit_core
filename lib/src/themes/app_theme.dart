import 'package:flutter/material.dart';
import 'package:flutter_toolkit/src/themes/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.neutral100,
    colorScheme: ColorScheme.light(
      surface: AppColors.white,
      onSurface: AppColors.black,
      onSurfaceVariant: AppColors.neutral600,
      surfaceContainer: AppColors.neutral600,
      surfaceBright: AppColors.neutral700,
      primary: AppColors.blue500,
      primaryContainer: AppColors.white,
      secondaryContainer: AppColors.neutral100,
      surfaceContainerHigh: AppColors.white,
      primaryFixed: AppColors.neutral100,
      onPrimary: AppColors.neutral950,
      inversePrimary: AppColors.neutral200,
      inverseSurface: AppColors.neutral300,
      secondary: AppColors.blue50,
      tertiary: AppColors.blue700,
      error: AppColors.red500,
      errorContainer: AppColors.red100,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.neutral900,
    colorScheme: ColorScheme.dark(
      surface: AppColors.black,
      onSurface: AppColors.white,
      onSurfaceVariant: AppColors.neutral400,
      surfaceContainer: AppColors.white,
      surfaceBright: AppColors.neutral300,
      primary: AppColors.blue500,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.neutral950,
      secondaryContainer: AppColors.neutral500,
      surfaceContainerHigh: AppColors.neutral700,
      primaryFixed: AppColors.neutral800,
      inversePrimary: AppColors.neutral700,
      inverseSurface: AppColors.neutral600,
      secondary: AppColors.blue50,
      tertiary: AppColors.blue700,
      error: AppColors.red500,
      errorContainer: AppColors.red100,
    ),
  );
}
