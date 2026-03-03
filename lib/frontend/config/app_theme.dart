import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'GoogleSansCode',

    brightness: Brightness.light,

    dividerColor: Colors.transparent,

    colorScheme: ColorScheme.fromSeed(
      brightness: .light,
      seedColor: const Color(0xffaded74),
      secondary: Colors.white,
      primaryContainer: const Color(0xff858383),
      onPrimaryContainer: const Color(0xff858383),
      secondaryContainer: const Color(0xfff4f0f0),
      onSecondaryContainer: const Color(0xff000000),
      tertiaryContainer: const Color(0xffd6d6d6),
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

    datePickerTheme: const DatePickerThemeData(
      headerHelpStyle: TextStyle(fontSize: 18),
      headerHeadlineStyle: TextStyle(fontSize: 16)
    )
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'GoogleSansCode',

    brightness: Brightness.dark,

    dividerColor: Colors.transparent,

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffaded74),

      brightness: Brightness.dark,

      // Core surfaces (no pure black)
      surface: const Color(0xff1a1a1a),
      onSurface: const Color(0xfff1f1f1),

      // Containers
      primaryContainer: const Color(0xff2b2b2b),
      onPrimaryContainer: const Color(0xffe6e6e6),

      secondary: const Color(0xff2f2f2f),
      secondaryContainer: const Color(0xff242424),
      onSecondaryContainer: const Color(0xfff3f3f3),

      tertiaryContainer: const Color(0xff454545),

      shadow: Colors.black54,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff242424),
      foregroundColor: Color(0xfff1f1f1),
      elevation: 0,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xff2a2a2a),

      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff3a3a3a), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff4a4a4a), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffaded74), width: 2),
      ),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xffaded74),
      selectionColor: Color(0xffaded74),
      selectionHandleColor: Color(0xffaded74),
    ),
  );
}