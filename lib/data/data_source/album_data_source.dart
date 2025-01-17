import 'package:flutter/services.dart';
import 'package:photo_gallery/core/error/exceptions.dart';
import 'package:photo_gallery/core/pegion/photo_gallery_api.dart';

class AlbumDataSource {
  final PhotoGalleryNativeHostApi _photoGalleryNativeHostApi;

  AlbumDataSource({
    required PhotoGalleryNativeHostApi photoGalleryNativeHostApi,
  }) : _photoGalleryNativeHostApi = photoGalleryNativeHostApi;

  Future<List<Album>> getAlbums() async {
    try {
      return await _photoGalleryNativeHostApi.getAlbums();
    } on PlatformException catch (e) {
      throw PhotoGalleryException(code: e.code);
    } catch (e) {
      throw Exception("Unknown error occurred: $e");
    }
  }
}
