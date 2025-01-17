import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/core/error/error_message.dart';
import 'package:photo_gallery/core/error/exceptions.dart';
import 'package:photo_gallery/core/error/failures.dart';
import 'package:photo_gallery/core/pegion/photo_gallery_api.dart';
import 'package:photo_gallery/data/data_source/photo_list_data_source.dart';
import 'package:photo_gallery/data/repository/photo_list_repository_impl.dart';
import 'package:photo_gallery/domain/entities/photo_entity.dart';

import 'photo_list_repository_impl_test.mocks.dart';

@GenerateMocks([PhotoListDataSource])
void main() {
  late PhotoListRepositoryImpl photoListRepository;
  late MockPhotoListDataSource mockPhotoListDataSource;

  final List<Photo> mockPhotos = [
    Photo(path: 'photo1.jpg'),
    Photo(path: 'photo2.jpg'),
  ];

  final List<PhotoEntity> mockPhotoEntities = mockPhotos
      .map((photo) => PhotoEntity(path: photo.path))
      .toList();

  setUp(() {
    mockPhotoListDataSource = MockPhotoListDataSource();
    photoListRepository = PhotoListRepositoryImpl(dataSource: mockPhotoListDataSource);
  });

  group('PhotoListRepositoryImpl', () {
    test('should return a list of PhotoEntity when data source returns photos', () async {
      // Arrange
      when(mockPhotoListDataSource.getPhotoList(any))
          .thenAnswer((_) async => mockPhotos);

      // Act
      final result = await photoListRepository.getPhotoList('album1');

      // Assert
      expect(result, Right(mockPhotoEntities));
      verify(mockPhotoListDataSource.getPhotoList('album1')).called(1);
      verifyNoMoreInteractions(mockPhotoListDataSource);
    });

    test('should return a PhotoGalleryFailure when data source throws PhotoGalleryException', () async {
      // Arrange
      const errorCode = 'SomeErrorCode';
      when(mockPhotoListDataSource.getPhotoList(any))
          .thenThrow(PhotoGalleryException(code: errorCode));

      // Act
      final result = await photoListRepository.getPhotoList('album1');

      // Assert
      expect(
        result,
        Left(PhotoGalleryFailure(
          failureMessage: ErrorMessageFactory.getErrorMessage(errorCode),
        )),
      );
      verify(mockPhotoListDataSource.getPhotoList('album1')).called(1);
      verifyNoMoreInteractions(mockPhotoListDataSource);
    });

    test('should return a PhotoGalleryFailure when data source throws a generic exception', () async {
      // Arrange
      const errorMessage = 'Unknown error occurred: Test Exception';
      when(mockPhotoListDataSource.getPhotoList(any))
          .thenThrow(Exception(errorMessage));

      // Act
      final result = await photoListRepository.getPhotoList('album1');

      // Assert
      expect(
        result,
        Left(PhotoGalleryFailure(
          failureMessage: ErrorMessageFactory.getErrorMessage(
            'Exception: Test Exception',
          ),
        )),
      );
      verify(mockPhotoListDataSource.getPhotoList('album1')).called(1);
      verifyNoMoreInteractions(mockPhotoListDataSource);
    });
  });
}
