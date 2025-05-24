import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: AppColors.transparent,
      scrolledUnderElevation: 0.0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(AppColors.borderColor),
      focusedBorder: _border(AppColors.gradient2),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundColor,
    ),
  );
}
