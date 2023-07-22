import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: Color.fromARGB(255, 199, 249, 255),
        secondary: Colors.grey[100]!,
        tertiary: Color.fromARGB(255, 6, 77, 135),
        onBackground: Colors.white),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent));
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: Colors.grey[700]!,
        secondary: Colors.grey[400]!,
        tertiary: Colors.grey[400]!,
        onBackground: Colors.grey[400]!),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent));
