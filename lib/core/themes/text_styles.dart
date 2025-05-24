import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  // Headings - Dark Theme
  static const TextStyle heading1Dark = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    height: 1.2,
  );

  static const TextStyle heading2Dark = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    height: 1.3,
  );

  static const TextStyle heading3Dark = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    height: 1.4,
  );

  static const TextStyle heading4Dark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle heading5Dark = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  // Body Text - Dark Theme
  static const TextStyle bodyLargeDark = TextStyle(
    fontSize: 18,
    color: AppColors.textDark,
    height: 1.6,
  );

  static const TextStyle bodyMediumDark = TextStyle(
    fontSize: 16,
    color: AppColors.textDark,
    height: 1.5,
  );

  static const TextStyle bodySmallDark = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondaryDark,
    height: 1.5,
  );

  static const TextStyle captionDark = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondaryDark,
  );

  // Headings - Light Theme
  static const TextStyle heading1Light = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    height: 1.2,
  );

  static const TextStyle heading2Light = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    height: 1.3,
  );

  static const TextStyle heading3Light = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
    height: 1.4,
  );

  static const TextStyle heading4Light = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  static const TextStyle heading5Light = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  // Body Text - Light Theme
  static const TextStyle bodyLargeLight = TextStyle(
    fontSize: 18,
    color: AppColors.textLight,
    height: 1.6,
  );

  static const TextStyle bodyMediumLight = TextStyle(
    fontSize: 16,
    color: AppColors.textLight,
    height: 1.5,
  );

  static const TextStyle bodySmallLight = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondaryLight,
    height: 1.5,
  );

  static const TextStyle captionLight = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondaryLight,
  );

  // Special Styles
  static const TextStyle gradientStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // Text Themes
  static TextTheme get darkTextTheme => const TextTheme(
    displayLarge: heading1Dark,
    displayMedium: heading2Dark,
    displaySmall: heading3Dark,
    headlineMedium: heading4Dark,
    headlineSmall: heading5Dark,
    titleLarge: heading5Dark,
    bodyLarge: bodyLargeDark,
    bodyMedium: bodyMediumDark,
    bodySmall: bodySmallDark,
    labelLarge: buttonText,
    labelSmall: captionDark,
  );

  static TextTheme get lightTextTheme => const TextTheme(
    displayLarge: heading1Light,
    displayMedium: heading2Light,
    displaySmall: heading3Light,
    headlineMedium: heading4Light,
    headlineSmall: heading5Light,
    titleLarge: heading5Light,
    bodyLarge: bodyLargeLight,
    bodyMedium: bodyMediumLight,
    bodySmall: bodySmallLight,
    labelLarge: buttonText,
    labelSmall: captionLight,
  );
}
