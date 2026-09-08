import 'package:flutter/material.dart';
import 'app_colors.dart';

extension ThemeExtension on BuildContext {

  bool get isDark =>
      Theme.of(this).brightness ==
          Brightness.dark;

  Color get bgColor =>
      isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground;

  Color get cardColor =>
      isDark
          ? AppColors.darkCard
          : AppColors.lightCard;

  Color get textColor =>
      isDark
          ? AppColors.darkText
          : AppColors.lightText;

  Color get subTextColor =>
      isDark
          ? AppColors.darkSubText
          : AppColors.lightSubText;


  Color get containerColor =>
      isDark
          ? AppColors.darkContainer
          : Colors.white;
}