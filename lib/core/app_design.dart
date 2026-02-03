import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark Theme Palette
  static const Color darkBg = Color(0xFF0F0F1E);
  static const Color darkCard = Color(0xFF1A1A2E);
  static const Color primary = Color(0xFF7B61FF); // Neon Violet
  static const Color accent = Color(0xFF12005E); // Deep Indigo
  static const Color secondary = Color(0xFFF0E6FF);
  
  // Light Theme Palette
  static const Color lightBg = Color(0xFFF8F9FE);
  static const Color lightCard = Colors.white;
  
  // Neutral Colors
  static const Color textMain = Colors.white;
  static const Color textDim = Colors.white70;
  static const Color glassBorder = Colors.white12;
  static const Color glassBg = Colors.white10;
}

class AppDesign {
 static ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      surface: AppColors.darkBg,
      onSurface: AppColors.textMain,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textMain,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textMain,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.darkCard,
      elevation: 4,
    ),
  );
}
  static BoxDecoration glassDecoration({double blur = 10.0, double radius = 16.0}) {
    return BoxDecoration(
      color: AppColors.glassBg,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: AppColors.glassBorder),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [AppColors.primary, AppColors.accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
