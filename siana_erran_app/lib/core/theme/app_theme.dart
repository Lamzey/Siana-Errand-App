import 'package:flutter/material.dart';

// Define the light color scheme based on the SignUp screen
final lightColorScheme = ColorScheme(
  primary: Color(0xFF007AFF), // Accent color for links and highlights
  secondary: Color(0xFF007AFF), // Assuming secondary is similar to primary
  surface: Color(0xFFFFFFFF), // Card and elevated surfaces
  error: Color(0xFFFF0000),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.light, // Corrected to Brightness enum
);

// Define the text theme using the custom font "Poppins" with Material 3 properties
final textTheme = TextTheme(
  headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Poppins'), // Updated from headline1
  labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'), // Updated from button
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Poppins'), // Updated from bodyText1
  bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, fontFamily: 'Poppins'), // Updated from caption
);

// Customize the elevated button theme to match the primary button style
final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF000000), // Updated from primary
    foregroundColor: Color(0xFFFFFFFF), // Updated from onPrimary
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);

// Set up the input decoration theme for text fields
final inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFFFFFFFF),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Color(0xFFE0E0E0)),
  ),
  labelStyle: TextStyle(color: Color(0xFF666666)),
  hintStyle: TextStyle(color: Color(0xFF666666)),
);

// Define the main theme data for the light theme
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: textTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  inputDecorationTheme: inputDecorationTheme,
  iconTheme: IconThemeData(color: Color(0xFF000000)),
  primaryIconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
  fontFamily: 'Poppins',
);

// Optional dark theme (if needed)
final darkColorScheme = ColorScheme(
  primary: Color(0xFF007AFF),
  secondary: Color(0xFF007AFF),
  surface: Color(0xFF000000),
  error: Color(0xFFFF0000),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFFFFFFFF),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.dark, // Corrected to Brightness enum
);

final elevatedButtonThemeDark = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF424242),
    foregroundColor: Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);

final inputDecorationThemeDark = InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFF424242),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Color(0xFF424242)),
  ),
  labelStyle: TextStyle(color: Color(0xFFB0B0B0)),
  hintStyle: TextStyle(color: Color(0xFF666666)),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: textTheme,
  elevatedButtonTheme: elevatedButtonThemeDark,
  inputDecorationTheme: inputDecorationThemeDark,
  iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
  primaryIconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
  fontFamily: 'Poppins',
);