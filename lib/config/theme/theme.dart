import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData customThemeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: white,
    accentColor: darkAccent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: AppColors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  scaffoldBackgroundColor: white[500],
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(
    TextTheme(
      displayLarge: const TextStyle(
        fontSize: 93,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      displayMedium: const TextStyle(
        fontSize: 58,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      displaySmall: const TextStyle(
        fontSize: 46,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.25,
        color: Colors.white,
      ),
      headlineSmall: const TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleLarge: const TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: Colors.white,
      ),
      titleMedium: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: white[200],
      ),
      bodyLarge: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      labelLarge: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      bodySmall: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelSmall: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),
  ),
);

const int _darkPrimaryValue = 0xFFFFFFFF; // White color
const MaterialColor white = MaterialColor(_darkPrimaryValue, <int, Color>{
  50: Color(0xFFFFFFFF),
  100: Color(0xFFFFFFFF),
  200: Color(0xFFFFFFFF),
  300: Color(0xFFFFFFFF),
  400: Color(0xFFFFFFFF),
  500: Color(_darkPrimaryValue),
  600: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
  800: Color(0xFFFFFFFF),
  900: Color(0xFFFFFFFF),
});

const int _darkAccentValue = 0xFFDBE3FF; // #DBE3FF color
const MaterialColor darkAccent = MaterialColor(_darkAccentValue, <int, Color>{
  100: Color(0xFFDBE3FF),
  200: Color(_darkAccentValue),
  400: Color(0xFFDBE3FF),
  700: Color(0xFFDBE3FF),
});

class AppColors {
  static const Color lightGrey = Color(0xFFAAA9B1);
  static const Color white = Color(0xFFFFFFFF);
  static const Color orange = Color(0xFFFFC319);
  static const Color purple = Color(0xFFDBE3FF);
  static const Color darkPurple = Color(0xFF88A4E8);
  static const Color black = Color(0xFF000000);
}
