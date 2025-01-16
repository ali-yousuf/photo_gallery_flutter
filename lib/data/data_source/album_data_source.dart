import 'package:photo_gallery/core/pegion/photo_gallery_api.dart';

class AlbumDataSource {
  final PhotoGalleryNativeHostApi _photoGalleryNativeHostApi;

  AlbumDataSource({
    required PhotoGalleryNativeHostApi photoGalleryNativeHostApi,
  }) : _photoGalleryNativeHostApi = photoGalleryNativeHostApi;

  Future<List<Album>> getAlbums() async {
    try {
      return await _photoGalleryNativeHostApi.getAlbums();
    } catch (e) {
      rethrow;
    }
  }
}
