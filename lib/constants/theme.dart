import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class BUTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: BUColors.primaryBlue,
        primary: BUColors.primaryBlue,
        secondary: BUColors.secondaryGold,
        surface: BUColors.cardLight,
      ),
      scaffoldBackgroundColor: BUColors.backgroundLight,
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        titleLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: BUColors.primaryBlue,
        ),
        titleMedium: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.outfit(
          color: BUColors.textLightPrimary,
        ),
        bodyMedium: GoogleFonts.outfit(
          color: BUColors.textLightSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: BUColors.primaryBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: BUColors.cardLight,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: BUColors.primaryBlue,
        primary: BUColors.primaryBlue,
        secondary: BUColors.secondaryGold,
        surface: BUColors.cardDark,
      ),
      scaffoldBackgroundColor: BUColors.backgroundDark,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
        titleLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: BUColors.secondaryGold,
        ),
        titleMedium: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.outfit(
          color: BUColors.textDarkPrimary,
        ),
        bodyMedium: GoogleFonts.outfit(
          color: BUColors.textDarkSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: BUColors.cardDark,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: BUColors.cardDark,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}


