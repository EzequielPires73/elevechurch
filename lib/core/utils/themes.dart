import 'package:elevechurch/core/utils/custom_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
  scaffoldBackgroundColor: Colors.grey[100],
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.black38,
    elevation: 4,
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
  ),
  popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(fontWeight: FontWeight.w400),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: Colors.black12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: Colors.black87),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: Colors.black12),
    ),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Colors.white,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
    surfaceTintColor: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: CustomColors.scaffoldColor,
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: CustomColors.bottomNavigationColor,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: CustomColors.bottomNavigationColor,
    surfaceTintColor: CustomColors.bottomNavigationColor,
  ),
  popupMenuTheme:
      const PopupMenuThemeData(color: CustomColors.bottomNavigationColor),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(fontWeight: FontWeight.w400),
    filled: true,
    fillColor: CustomColors.cardColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 0),
    ),
  ),
  cardTheme: const CardTheme(
    color: CustomColors.cardColor,
  ),
  brightness: Brightness.dark,
);
