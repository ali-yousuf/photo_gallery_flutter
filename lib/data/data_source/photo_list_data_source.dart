import 'package:flutter/services.dart';
import 'package:photo_gallery/core/error/exceptions.dart';
import 'package:photo_gallery/core/pegion/photo_gallery_api.dart';

class PhotoListDataSource {
  final PhotoGalleryNativeHostApi _photoGalleryNativeHostApi;

  PhotoListDataSource({
    required PhotoGalleryNativeHostApi photoGalleryNativeHostApi,
  }) : _photoGalleryNativeHostApi = photoGalleryNativeHostApi;

  Future<List<Photo>> getPhotoList(String album) async {
    try {
      return await _photoGalleryNativeHostApi.getPhotos(album);
    } on PlatformException catch (e) {
      throw PhotoGalleryException(code: e.code);
    } catch (e) {
      throw Exception("Unknown error occurred: $e");
    }
  }
}
