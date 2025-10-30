import "package:flutter/material.dart";
import "package:flutter_habit_tracker/core/constants/app_colors.dart";

class MyElevatedButtonTheme {
  MyElevatedButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.dividerLight;
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColors.secondaryLight;
            }
            return AppColors.primaryLight;
          }),
          foregroundColor: WidgetStateProperty.all(AppColors.white),
          overlayColor: WidgetStateProperty.all(
            AppColors.accentLight.withOpacity(0.1),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 18)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.primaryLight),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      );
  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.dividerDark;
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColors.secondaryDark;
            }
            return AppColors.primaryDark;
          }),
          foregroundColor: WidgetStateProperty.all(AppColors.black),
          overlayColor: WidgetStateProperty.all(
            AppColors.accentDark.withOpacity(0.1),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 18)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.primaryDark),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      );
}
