import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.darkColor,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );
}
