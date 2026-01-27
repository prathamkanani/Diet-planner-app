import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'GoogleSansCode',

    brightness: Brightness.light,

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffaded74),
      secondary: Colors.white,
      primaryContainer: const Color(0xff858383),
      onPrimaryContainer: const Color(0xfff8f5f5),
      secondaryContainer: const Color(0xffeae6e6),
      onSecondaryContainer: const Color(0xff000000),
      onSurface: Colors.black,
      shadow: Colors.black,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
      headlineLarge: TextStyle(color: Colors.black),
      headlineMedium: TextStyle(color: Colors.black),
      headlineSmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      labelLarge: TextStyle(color: Colors.black),
      labelMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.black),
    ),

    inputDecorationTheme: const InputDecorationThemeData(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffd6d1d1), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffd6d1d1), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.blue,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffaded74),
      onSurface: Colors.white,
    ),
    textTheme: GoogleFonts.googleSansCodeTextTheme(),
  );
}
