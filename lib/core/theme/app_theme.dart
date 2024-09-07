import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';

class AppTheme {
  static _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 3,
      ),
      borderRadius: BorderRadius.circular(10));
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.borderColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: _border(
          AppColors.borderColor,
        ),
        enabledBorder: _border(
          AppColors.greyColor,
        ),
      ));
}
