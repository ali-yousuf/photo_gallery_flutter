part of 'albums_cubit.dart';

sealed class AlbumsState extends Equatable {}

final class AlbumsInitial extends AlbumsState {
  @override
  List<Object?> get props => [];
}

final class AlbumsLoading extends AlbumsState {
  @override
  List<Object?> get props => [];
}

final class AlbumsLoaded extends AlbumsState {
  final List<AlbumEntity> albums;

  AlbumsLoaded({required this.albums});

  @override
  List<Object?> get props => [albums];
}

final class AlbumNotFound extends AlbumsState{
  @override
  List<Object?> get props => [];
}

final class AlbumsFailure extends AlbumsState {
  final String  failureMessage;

  AlbumsFailure(this.failureMessage);

  @override
  List<Object?> get props => [failureMessage];
}
