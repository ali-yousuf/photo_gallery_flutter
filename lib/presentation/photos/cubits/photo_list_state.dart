part of 'photo_list_cubit.dart';

sealed class PhotoListState extends Equatable {
  const PhotoListState();
}

final class PhotoListInitial extends PhotoListState {
  @override
  List<Object> get props => [];
}

final class PhotoListLoading extends PhotoListState {
  @override
  List<Object> get props => [];
}

final class PhotoListLoaded extends PhotoListState {
  final List<PhotoEntity> photoList;

  const PhotoListLoaded({required this.photoList});

  @override
  List<Object> get props => [photoList];
}

final class PhotoListFailure extends PhotoListState {
  @override
  List<Object> get props => [];
}

final class NoPhotoFound extends PhotoListState {
  @override
  List<Object> get props => [];
}
