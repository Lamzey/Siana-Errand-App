import 'package:flutter/material.dart';

// Light color scheme
final lightColorScheme = ColorScheme(
  primary: Color(0xFF007AFF),
  secondary: Color(0xFF007AFF),
  surface: Color(0xFFFFFFFF),
  error: Color(0xFFFF0000),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.light,
);

// TextTheme all in GothamRounded
final textTheme = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    fontFamily: 'GothamRounded',
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    fontFamily: 'GothamRounded',
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    fontFamily: 'GothamRounded',
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'GothamRounded',
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'GothamRounded',
  ),
  titleSmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'GothamRounded',
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'GothamRounded',
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: 'GothamRounded',
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: 'GothamRounded',
  ),
  labelLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'GothamRounded',
  ),
  labelMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'GothamRounded',
  ),
  labelSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'GothamRounded',
  ),
);

// Elevated button theme (GothamRounded)
final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF000000),
    foregroundColor: Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: TextStyle(
      fontFamily: 'GothamRounded',
      fontWeight: FontWeight.w500,
    ),
  ),
);

// Input fields (GothamRounded)
final inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFFFFFFFF),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Color(0xFFE0E0E0)),
  ),
  labelStyle: TextStyle(color: Color(0xFF666666), fontFamily: 'GothamRounded'),
  hintStyle: TextStyle(color: Color(0xFF666666), fontFamily: 'GothamRounded'),
);

// Light ThemeData
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: textTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  inputDecorationTheme: inputDecorationTheme,
  iconTheme: IconThemeData(color: Color(0xFF000000)),
  primaryIconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
  fontFamily: 'GothamRounded',
);

// Dark color scheme
final darkColorScheme = ColorScheme(
  primary: Color(0xFF007AFF),
  secondary: Color(0xFF007AFF),
  surface: Color(0xFF000000),
  error: Color(0xFFFF0000),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFFFFFFFF),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.dark,
);

// Dark Elevated button (GothamRounded)
final elevatedButtonThemeDark = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF424242),
    foregroundColor: Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: TextStyle(
      fontFamily: 'GothamRounded',
      fontWeight: FontWeight.w500,
    ),
  ),
);

// Dark inputs (GothamRounded)
final inputDecorationThemeDark = InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFF424242),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Color(0xFF424242)),
  ),
  labelStyle: TextStyle(color: Color(0xFFB0B0B0), fontFamily: 'GothamRounded'),
  hintStyle: TextStyle(color: Color(0xFF666666), fontFamily: 'GothamRounded'),
);

// Dark ThemeData
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: textTheme,
  elevatedButtonTheme: elevatedButtonThemeDark,
  inputDecorationTheme: inputDecorationThemeDark,
  iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
  primaryIconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
  fontFamily: 'GothamRounded',
);
