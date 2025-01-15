import 'package:flutter/material.dart';
import 'package:photo_gallery/app/app_colors.dart';
import 'package:photo_gallery/app/text_styles.dart';

class ButtonStyles {
  static ButtonStyle filledButtonStyle = FilledButton.styleFrom(
    textStyle: TextStyles.buttonTextStyle,
    foregroundColor: AppColors.black,
    backgroundColor: AppColors.primaryColor,
    minimumSize: const Size(396, 42),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}
