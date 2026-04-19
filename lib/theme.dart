import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryCyan = Color(0xFF06B6D4);
  static const Color primaryBlue = Color(0xFF3B82F6);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF1F5F9),
    primaryColor: primaryCyan,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF020617),
    primaryColor: primaryCyan,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [primaryCyan, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}