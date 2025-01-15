import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/domain/entities/photo_entity.dart';
import 'package:photo_gallery/domain/repository/photo_list_repository.dart';

part 'photo_list_state.dart';

class PhotoListCubit extends Cubit<PhotoListState> {
  PhotoListCubit(this._repository) : super(PhotoListInitial());
  final PhotoListRepository _repository;

  Future<void> loadPhotoList(String album) async {
    emit(PhotoListLoading());
    try {
      final photoList = await _repository.getPhotoList(album);
      if (photoList.isNotEmpty) {
        emit(PhotoListLoaded(photoList: photoList));
      } else {
        emit(NoPhotoFound());
      }
    } catch (e) {
      emit(PhotoListFailure());
    }
  }
}
