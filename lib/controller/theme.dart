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
      headline1: GoogleFonts.poppins(
        color: const Color(0xFFADB5BD),
        fontSize: 16,
      ),
      headline2: GoogleFonts.poppins(
        color: const Color(0xFFEDF2FB),
        fontSize: 16,
      ),
      headline3: GoogleFonts.poppins(
        color: const Color(0xFF80FFDB),
        fontSize: 16,
      ),
      headline4: GoogleFonts.poppins(
        color: const Color(0xFFF72585),
        fontSize: 16,
      ),
      headline5: GoogleFonts.poppins(
        color: const Color(0xFF80FFDB),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline6: GoogleFonts.poppins(
        color: const Color(0xFFF72585),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF343A40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
