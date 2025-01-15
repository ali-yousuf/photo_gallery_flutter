import 'package:photo_gallery/domain/entities/photo_entity.dart';

abstract class PhotoListRepository {
  Future<List<PhotoEntity>> getPhotoList(String album);
}
