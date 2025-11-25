import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF8F9FC),
    primaryColor: const Color(0xFF4e73df),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF4e73df),
      primary: Color(0xFF4e73df),
      secondary: Color(0xFF1cc88a),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontFamily: "Poppins"),
    ),
  );
}
