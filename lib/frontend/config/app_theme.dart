import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'GoogleSansCode',

    brightness: Brightness.light,

    dividerColor: Colors.transparent,

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffaded74),
      secondary: Colors.white,
      primaryContainer: const Color(0xff858383),
      onPrimaryContainer: const Color(0xfff8f5f5),
      secondaryContainer: const Color(0xfff4f0f0),
      onSecondaryContainer: const Color(0xff000000),
      surface: Colors.white,
      onSurface: Colors.black,
      shadow: Colors.black,
    ),

    appBarTheme: const AppBarTheme(backgroundColor: Color(0xfff4f0f0)),

    inputDecorationTheme: const InputDecorationThemeData(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffd6d1d1), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffa6a3a3), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
      filled: true,
      fillColor: Color(0xFFFFFFFF),
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
