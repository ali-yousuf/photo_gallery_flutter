import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/core/pegion/photo_gallery_api.dart';
import 'package:photo_gallery/data/data_source/album_data_source.dart';
import 'album_data_source_test.mocks.dart';

@GenerateMocks([PhotoGalleryNativeHostApi])
void main() {
  late MockPhotoGalleryNativeHostApi mockNativeHostApi;
  late AlbumDataSource albumDataSource;

  setUp(() {
    mockNativeHostApi = MockPhotoGalleryNativeHostApi();
    albumDataSource = AlbumDataSource(photoGalleryNativeHostApi: mockNativeHostApi);
  });

  group('AlbumDataSource', () {
    test('should return a list of albums successful', () async {
      // Arrange
      final mockAlbums = [
        Album(name: 'Album 1', thumbnail: "", photoCount: 10),
        Album(name: 'Album 1', thumbnail: "", photoCount: 10),
      ];
      when(mockNativeHostApi.getAlbums()).thenAnswer((_) async => mockAlbums);

      // Act
      final result = await albumDataSource.getAlbums();

      // Assert
      expect(result, mockAlbums);
      verify(mockNativeHostApi.getAlbums()).called(1);
    });

    test('should throw an exception', () async {
      // Arrange
      final exception = Exception('Failed to fetch albums');
      when(mockNativeHostApi.getAlbums()).thenThrow(exception);

      // Act & Assert
      expect(() => albumDataSource.getAlbums(), throwsA(exception));
      verify(mockNativeHostApi.getAlbums()).called(1);
    });
  });
}
