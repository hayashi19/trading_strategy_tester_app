import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF343A40),
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(33, 37, 41, 1),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF343A40),
      foregroundColor: Color(0xFFADB5BD),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        color: const Color(0xFFADB5BD),
        fontSize: 18,
      ),
      displayMedium: GoogleFonts.poppins(
        color: const Color(0xFFEDF2FB),
        fontSize: 18,
      ),
      displaySmall: GoogleFonts.poppins(
        color: const Color(0xFF80FFDB),
        fontSize: 18,
      ),
      headlineLarge: GoogleFonts.poppins(
        color: const Color(0xFFF72585),
        fontSize: 18,
      ),
      headlineMedium: GoogleFonts.poppins(
        color: const Color(0xFF80FFDB),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.poppins(
        color: const Color(0xFFF72585),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF343A40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFADB5BD),
      size: 16,
    ),
  );
}
