import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
    ),
  );

  // Gradient for Tinder-style screens
  static const LinearGradient tinderGradient = LinearGradient(
    colors: [Color(0xFFFE3C72), Color(0xFFFF655B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  // Add this static TextStyle for headings
  static const TextStyle head1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
