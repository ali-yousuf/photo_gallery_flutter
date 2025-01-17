import 'package:flutter/material.dart';
import 'package:photo_gallery/app/text_styles.dart';
import 'package:photo_gallery/l10n/l10n.dart';

class FailureMessageView extends StatelessWidget {
  const FailureMessageView({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? context.l10n.noDataFound,
        style: TextStyles.albumTitleTextStyle,
      ),
    );
  }
}
