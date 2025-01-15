import 'package:flutter/material.dart';
import 'package:photo_gallery/app/app_colors.dart';

class TextStyles {
  static const String fontFamily = 'Roboto';

  //permission request screen
  static TextStyle bodySmall = TextStyle(
    color: AppColors.graniteGray,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static TextStyle bodyMedium = bodySmall.copyWith(
    color: AppColors.raisinBlack,
    fontSize: 20,
  );

  static TextStyle buttonTextStyle = bodySmall.copyWith(
    color: AppColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  //album screen
  static TextStyle albumTitleTextStyle = bodySmall.copyWith(
    color: AppColors.jetBlack,
    fontSize: 26,
    fontWeight: FontWeight.w500,
  );

  static TextStyle albumItemTitleTextStyle = bodySmall.copyWith(
    color: AppColors.white,
    fontSize: 20,
  );

  static TextStyle albumItemSubTitleTextStyle = bodySmall.copyWith(
    color: AppColors.lightSilver,
    fontSize: 14,
  );

  //photo list
  static TextStyle photoListTextStyle = bodySmall.copyWith(
    color: AppColors.black,
    fontSize: 20,
  );
}
