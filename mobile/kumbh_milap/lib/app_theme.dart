import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define Color Palette
  static const Color primaryColor = Color(0xFFE37757); // Deep Blue
  static const Color secondaryColor = Color(0xFF205AC8); // Soft Yellow
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF58585C); // Dark Gray
  static Color? lightGray = Colors.grey[300]; // Light Gray
  static Color? darkGray = Colors.grey[600];
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: GoogleFonts.martel().fontFamily, // Default Font: Poppins

    textTheme: TextTheme(
      displayLarge: GoogleFonts.martel(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displayMedium: GoogleFonts.martel(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: textColor,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  );
}
