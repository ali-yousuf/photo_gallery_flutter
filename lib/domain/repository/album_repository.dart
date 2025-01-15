import 'package:photo_gallery/domain/entities/album_entity.dart';

abstract class AlbumRepository{
  Future<List<AlbumEntity>> getAlbums();
}