import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/core/error/error_message.dart';
import 'package:photo_gallery/core/error/exceptions.dart';
import 'package:photo_gallery/core/error/failures.dart';
import 'package:photo_gallery/core/pegion/photo_gallery_api.dart';
import 'package:photo_gallery/data/data_source/album_data_source.dart';
import 'package:photo_gallery/data/repository/album_repository_impl.dart';
import 'package:photo_gallery/domain/entities/album_entity.dart';

import 'album_repository_impl_test.mocks.dart';

@GenerateMocks([AlbumDataSource])
void main() {
  late AlbumRepositoryImpl albumRepository;
  late MockAlbumDataSource mockAlbumDataSource;

  final mockAlbums = [
    Album(name: 'Album1', thumbnail: 'thumbnail1', photoCount: 10),
    Album(name: 'Album2', thumbnail: 'thumbnail2', photoCount: 20),
  ];

  final mockAlbumEntities = mockAlbums
      .map((e) => AlbumEntity(
            name: e.name,
            thumbnail: e.thumbnail,
            photoCount: e.photoCount,
          ))
      .toList();

  setUp(() {
    mockAlbumDataSource = MockAlbumDataSource();
    albumRepository = AlbumRepositoryImpl(albumDataSource: mockAlbumDataSource);
  });

  group('AlbumRepositoryImpl', () {
    test('should return a list of AlbumEntity when data source returns albums', () async {
      // Arrange
      when(mockAlbumDataSource.getAlbums()).thenAnswer((_) async => mockAlbums);

      // Act
      final result = await albumRepository.getAlbums();

      // Assert
      result.fold(
        (failure) => fail('Expected a Right but got a Left: $failure'),
        (albums) => expect(albums, equals(mockAlbumEntities)),
      );
      verify(mockAlbumDataSource.getAlbums()).called(1);
      verifyNoMoreInteractions(mockAlbumDataSource);
    });

    test('should return a PhotoGalleryFailure when data source throws PhotoGalleryException', () async {
      // Arrange
      const errorCode = 'SomeErrorCode';
      final expectedFailure = PhotoGalleryFailure(
        failureMessage: ErrorMessageFactory.getErrorMessage(errorCode),
      );
      when(mockAlbumDataSource.getAlbums()).thenThrow(PhotoGalleryException(code: errorCode));

      // Act
      final result = await albumRepository.getAlbums();

      // Assert
      result.fold(
        (failure) => expect(failure, equals(expectedFailure)),
        (_) => fail('Expected a Left but got a Right'),
      );
      verify(mockAlbumDataSource.getAlbums()).called(1);
      verifyNoMoreInteractions(mockAlbumDataSource);
    });

    test('should return a PhotoGalleryFailure when data source throws a generic exception', () async {
      // Arrange
      const genericErrorMessage = 'Unknown error occurred: Test Exception';
      final expectedFailure = PhotoGalleryFailure(
        failureMessage: ErrorMessageFactory.getErrorMessage('ALBUM_NOT_FOUND'),
      );
      when(mockAlbumDataSource.getAlbums()).thenThrow(Exception(genericErrorMessage));

      // Act
      final result = await albumRepository.getAlbums();

      // Assert
      result.fold(
        (failure) => expect(failure, equals(expectedFailure)),
        (_) => fail('Expected a Left but got a Right'),
      );
      verify(mockAlbumDataSource.getAlbums()).called(1);
      verifyNoMoreInteractions(mockAlbumDataSource);
    });
  });
}
