import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/core/error/failure_to_message_converter.dart';

import 'package:photo_gallery/domain/entities/album_entity.dart';
import 'package:photo_gallery/domain/repository/album_repository.dart';

part 'albums_state.dart';

class AlbumsCubit extends Cubit<AlbumsState> {
  AlbumsCubit(this.repository) : super(AlbumsInitial());

  final AlbumRepository repository;

  Future<void> loadAlbums() async {
    emit(AlbumsLoading());
    final albums = await repository.getAlbums();
    albums.fold((failure) {
      emit(
        AlbumsFailure(
          FailureToMessageConverter.convert(failure),
        ),
      );
    }, (albums) {
      if (albums.isNotEmpty) {
        emit(AlbumsLoaded(albums: albums));
      } else {
        emit(AlbumNotFound());
      }
    });
  }
}
