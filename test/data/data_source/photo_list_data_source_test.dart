import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/core/pegion/photo_gallery_api.dart';
import 'package:photo_gallery/data/data_source/photo_list_data_source.dart';

import 'photo_list_data_source_test.mocks.dart';

@GenerateMocks([PhotoGalleryNativeHostApi])
void main() {
  late MockPhotoGalleryNativeHostApi mockNativeHostApi;
  late PhotoListDataSource photoListDataSource;

  setUp(() {
    mockNativeHostApi = MockPhotoGalleryNativeHostApi();
    photoListDataSource = PhotoListDataSource(photoGalleryNativeHostApi: mockNativeHostApi);
  });

  group('PhotoListDataSource', () {
    test('should return a list of photos successful', () async {
      // Arrange
      const album = 'Test Album';
      final mockPhotos = [
        Photo(path: '/path/to/photo1.jpg'),
        Photo(path: '/path/to/photo2.jpg'),
      ];
      when(mockNativeHostApi.getPhotos(album)).thenAnswer((_) async => mockPhotos);

      // Act
      final result = await photoListDataSource.getPhotoList(album);

      // Assert
      expect(result, mockPhotos);
      verify(mockNativeHostApi.getPhotos(album)).called(1);
    });

    test('should throw an exception', () async {
      // Arrange
      const album = 'Test Album';
      final exception = Exception('Failed to fetch photos');
      when(mockNativeHostApi.getPhotos(album)).thenThrow(exception);

      // Act & Assert
      expect(() => photoListDataSource.getPhotoList(album), throwsA(exception));
      verify(mockNativeHostApi.getPhotos(album)).called(1);
    });
  });
}
