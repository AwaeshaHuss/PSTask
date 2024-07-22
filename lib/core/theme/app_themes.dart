import 'package:flutter/material.dart';
import 'package:ps_task/core/theme/app_colors.dart';
import 'package:ps_task/core/theme/app_fonts.dart';

class AppTheme {
  ///lightMode
  static final ThemeData lightMode = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppFonts.seezBlack18,
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primary_1,
        minimumSize: const Size(130.0, 34.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      splashColor: Colors.red,
      buttonColor: const Color(0xFF7A3FE1),
      height: 34.0,
      highlightColor: Colors.green,
      textTheme: ButtonTextTheme.normal,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 26.0,
        fontFamily: AppFonts.seez,
        color: const Color(0xff2E2B2A),
        height: 2.0,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontFamily: AppFonts.seez,
        color: AppColors.primary_1,
        height: 1.8,
      ),
      bodySmall: TextStyle(
        fontSize: 10.0,
        fontFamily: AppFonts.seez,
        color: AppColors.primary_1,
        height: 1.3,
      ),
    ),
  );

  ///darkMode
  static final ThemeData darkMode = lightMode.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.black,
        backgroundColor: AppColors.primary_2,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 26.0,
        fontFamily: AppFonts.seez,
        color: AppColors.white,
        height: 2.0,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontFamily: AppFonts.seez,
        color: AppColors.grey,
        height: 1.8,
      ),
      bodySmall: TextStyle(
        fontSize: 10.0,
        fontFamily: AppFonts.seez,
        color: AppColors.secondary_1,
        height: 1.3,
      ),
    ),
  );
}