import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static getApplicationTheme() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 39, 29, 29),
      ),
      fontFamily: "Arial",
      scaffoldBackgroundColor: const Color.fromARGB(255, 27, 28, 25),
      useMaterial3: false,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 6, 6, 6),
          backgroundColor: Colors.grey[300],
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 27, 28, 25),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
