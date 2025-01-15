import 'package:flutter/material.dart';
import 'package:photo_gallery/app/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        fontFamily: 'Roboto',
      );
}
