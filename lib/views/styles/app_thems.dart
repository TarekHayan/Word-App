import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:words_app/views/styles/app_colors.dart';

abstract class AppThems {
  static ThemeData appThems() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.black,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.black,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}
