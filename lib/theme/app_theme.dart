import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 73, 20, 158);

  static final ThemeData customTheme = ThemeData.light().copyWith(
    // Primary
    primaryColor: primary,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),

    // Scaffold Theme
    scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 235),
  );
}
