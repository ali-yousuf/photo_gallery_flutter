import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/core/error/failures.dart';
import 'package:photo_gallery/domain/entities/album_entity.dart';
import 'package:photo_gallery/domain/repository/album_repository.dart';
import 'package:photo_gallery/presentation/albums/cubits/albums_cubit.dart';

import 'albums_cubit_test.mocks.dart';

@GenerateMocks([AlbumRepository])
void main() {
  late MockAlbumRepository mockAlbumRepository;
  late AlbumsCubit albumsCubit;

  final List<AlbumEntity> mockAlbums = [
    AlbumEntity(name: 'Vacation', thumbnail: 'vacation_thumb.jpg', photoCount: 50),
    AlbumEntity(name: 'Birthday', thumbnail: 'birthday_thumb.jpg', photoCount: 30),
  ];

  setUp(() {
    mockAlbumRepository = MockAlbumRepository();
    albumsCubit = AlbumsCubit(mockAlbumRepository);
  });

  tearDown(() {
    albumsCubit.close();
  });

  group('AlbumsCubit', () {
    test('initial state should be AlbumsInitial', () {
      expect(albumsCubit.state, AlbumsInitial());
    });

    blocTest<AlbumsCubit, AlbumsState>(
      'emits [AlbumsLoading, AlbumsLoaded] when loadAlbums succeeds and albums are found',
      build: () => albumsCubit,
      setUp: () {
        when(mockAlbumRepository.getAlbums()).thenAnswer(
          (_) async => Right(mockAlbums),
        );
      },
      act: (cubit) => cubit.loadAlbums(),
      expect: () => [
        AlbumsLoading(),
        AlbumsLoaded(albums: mockAlbums),
      ],
      verify: (cubit) {
        verify(mockAlbumRepository.getAlbums()).called(1);
      },
    );

    blocTest<AlbumsCubit, AlbumsState>(
      'emits [AlbumsLoading, AlbumNotFound] when loadAlbums succeeds but no albums are found',
      build: () => albumsCubit,
      setUp: () {
        when(mockAlbumRepository.getAlbums()).thenAnswer(
          (_) async => const Right([]),
        );
      },
      act: (cubit) => cubit.loadAlbums(),
      expect: () => [
        AlbumsLoading(),
        AlbumNotFound(),
      ],
      verify: (cubit) {
        verify(mockAlbumRepository.getAlbums()).called(1);
      },
    );

    blocTest<AlbumsCubit, AlbumsState>(
      'emits [AlbumsLoading, AlbumsFailure] when loadAlbums fails',
      build: () => albumsCubit,
      setUp: () {
        when(mockAlbumRepository.getAlbums()).thenAnswer(
          (_) async => Left(
            PhotoGalleryFailure(failureMessage: 'Error fetching albums'),
          ),
        );
      },
      act: (cubit) => cubit.loadAlbums(),
      expect: () => [
        AlbumsLoading(),
        AlbumsFailure('Error fetching albums'),
      ],
      verify: (cubit) {
        verify(mockAlbumRepository.getAlbums()).called(1);
      },
    );
  });
}
