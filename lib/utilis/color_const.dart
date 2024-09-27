import 'package:flutter/material.dart';

// light theme data
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    surface: Colors.white70,
    inverseSurface: Colors.black,
    seedColor: Colors.black,
    primary: Colors.white,
    secondary: Colors.black,
    brightness: Brightness.light,
  ),
);

// dark theme data
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    inverseSurface: Colors.grey.shade100,
    surface: Colors.black87,
    seedColor: Colors.white,
    primary: Colors.black,
    secondary: Colors.white,
    brightness: Brightness.dark,
  ),
);
