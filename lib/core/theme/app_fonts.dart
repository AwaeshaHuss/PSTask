import 'package:flutter/material.dart';
import 'package:ps_task/core/theme/app_colors.dart';

class AppFonts{

  AppFonts._();

  static const String _fontsRootPath = 'assets/fonts/';

  static String get seez => '${_fontsRootPath}Seez.ttf';

  static TextStyle seezBlack26 = TextStyle(
    fontFamily: seez,
    fontSize: 26.0,
    height: 1.5,
    color: AppColors.black,
  );
  static TextStyle seezBlack20 = TextStyle(
    fontFamily: seez,
    fontSize: 20.0,
    height: 1.5,
    color: AppColors.black,
  );
  static TextStyle seezBlack18 = TextStyle(
    fontFamily: seez,
    fontSize: 18.0,
    height: 1.5,
    color: AppColors.black,
  );
  /// Seez-Bold
  static TextStyle seezBold20 = TextStyle(
    fontFamily: seez,
    fontSize: 20.0,
    height: 1.5,
    color: AppColors.black,
  );
}
