import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/text_styles.dart';
import 'package:photo_gallery/domain/entities/album_entity.dart';
import 'package:photo_gallery/l10n/l10n.dart';
import 'package:photo_gallery/presentation/albums/cubits/albums_cubit.dart';
import 'package:photo_gallery/presentation/widgets/failure_message_view.dart';
import 'package:photo_gallery/presentation/photos/photo_list_screen.dart';
import 'package:photo_gallery/presentation/widgets/progress_loader.dart';

class AlbumGridView extends StatelessWidget {
  const AlbumGridView({
    super.key,
    required this.albumsCubit,
  });

  final AlbumsCubit albumsCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumsCubit, AlbumsState>(
      bloc: albumsCubit,
      builder: (context, state) {
        if (state is AlbumsLoading) {
          return const ProgressLoader();
        } else if (state is AlbumsLoaded) {
          return _buildAlbumGridView(state.albums);
        } else if (state is AlbumsFailure) {
          return FailureMessageView(
            message: state.failureMessage,
          );
        }
        return const FailureMessageView();
      },
    );
  }

  Widget _buildAlbumGridView(List<AlbumEntity> albums) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 4.0,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        return _AlbumCard(albumEntity: albums[index]);
      },
    );
  }
}

class _AlbumCard extends StatelessWidget {
  const _AlbumCard({
    required this.albumEntity,
  });

  final AlbumEntity albumEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoListScreen(album: albumEntity.name),
          ),
        );
      },
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(albumEntity.thumbnail),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Grey overlay
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          // Text details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  albumEntity.name,
                  style: TextStyles.albumItemTitleTextStyle,
                ),
                Text(
                  '${albumEntity.photoCount} ${context.l10n.photos}',
                  style: TextStyles.albumItemSubTitleTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
