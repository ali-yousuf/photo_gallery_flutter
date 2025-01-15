import 'package:flutter/material.dart';
import 'package:photo_gallery/app/text_styles.dart';
import 'package:photo_gallery/l10n/l10n.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.noDataFound,
        style: TextStyles.albumTitleTextStyle,
      ),
    );
  }
}
