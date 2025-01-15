import 'package:flutter/material.dart';
import 'package:photo_gallery/app/text_styles.dart';
import 'package:photo_gallery/di/service_locator.dart';
import 'package:photo_gallery/l10n/l10n.dart';
import 'package:photo_gallery/presentation/albums/cubits/albums_cubit.dart';
import 'package:photo_gallery/presentation/albums/widgets/album_grid_view.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  final AlbumsCubit _albumsCubit = sl.get();

  @override
  void initState() {
    super.initState();
    _albumsCubit.loadAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            Expanded(child: AlbumGridView(albumsCubit: _albumsCubit)),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 44, bottom: 12),
      child: Text(context.l10n.albums, style: TextStyles.albumTitleTextStyle),
    );
  }
}
