import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFFFD6F00);
  static const Color accentColor = Color(0xFFE46400);
  static const Color primaryDark = Color(0xFFCA5900);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSecondary = Color(0xFF121212);
  static const Color darkTertiary = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF0F0F0F);
  static const Color darkBorder = Color(0xFF2A2A2A);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSecondary = Color(0xFFF5F5F5);
  static const Color lightTertiary = Color(0xFFEEEEEE);
  static const Color lightCard = Color(0xFFFAFAFA);
  static const Color lightBorder = Color(0xFFE0E0E0);

  // Text Colors
  static const Color textDark = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFF121212);
  static const Color textSecondaryDark = Color(0xFFD9D9D9);
  static const Color textSecondaryLight = Color(0xFF575757);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, accentColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Additional Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
}

class AppTheme {
  static const Color primaryColor = Color(0xFFFD6F00);
  static const Color accentColor = Color(0xFFE46400);
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSecondary = Color(0xFF121212);
  static const Color darkTertiary = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF0F0F0F);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSecondary = Color(0xFFF5F5F5);
  static const Color lightCard = Color(0xFFFAFAFA);
  static const Color textDark = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFF121212);
  static const Color textSecondaryDark = Color(0xFFD9D9D9);
  static const Color textSecondaryLight = Color(0xFF575757);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkCard,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: darkSecondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBackground,
      cardColor: lightCard,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: lightSecondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
