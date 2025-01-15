import 'package:flutter/material.dart';
import 'package:photo_gallery/app/text_styles.dart';
import 'package:photo_gallery/l10n/l10n.dart';

class EmptyAlbums extends StatelessWidget {
  const EmptyAlbums({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.noAlbumFound,
        style: TextStyles.albumTitleTextStyle,
      ),
    );
  }
}
