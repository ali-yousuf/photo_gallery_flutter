import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/core/error/failure_to_message_converter.dart';
import 'package:photo_gallery/domain/entities/photo_entity.dart';
import 'package:photo_gallery/domain/repository/photo_list_repository.dart';

part 'photo_list_state.dart';

class PhotoListCubit extends Cubit<PhotoListState> {
  PhotoListCubit(this._repository) : super(PhotoListInitial());
  final PhotoListRepository _repository;

  Future<void> loadPhotoList(String album) async {
    emit(PhotoListLoading());
    final photosEither = await _repository.getPhotoList(album);
    photosEither.fold((failure) {
      emit(
        PhotoListFailure(
          FailureToMessageConverter.convert(failure),
        ),
      );
    }, (photos) {
      if (photos.isNotEmpty) {
        emit(PhotoListLoaded(photoList: photos));
      } else {
        emit(NoPhotoFound());
      }
    });
  }
}
