import 'package:flutter/material.dart';

// Light theme
final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  hintColor: Colors.red,
  // Add more properties to customize your theme
);
  // Dark theme
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1F1F1F),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1F1F1F),
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF3A3A3A),
      secondary: Color(0xFF03DAC6),
      surface: Color(0xFF1F1F1F),
      background: Color(0xFF121212),
      error: Color(0xFFCF6679),
    ),
    cardColor: Color(0xFF1F1F1F),
    dividerColor: Colors.white12,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white60),
    ),
    iconTheme: IconThemeData(color: Colors.white70),
  );
