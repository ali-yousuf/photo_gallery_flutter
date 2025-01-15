import 'package:photo_gallery/data/data_source/alubms_data_source.dart';
import 'package:photo_gallery/domain/entities/album_entity.dart';
import 'package:photo_gallery/domain/repository/album_repository.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final AlbumDataSource _albumDataSource;

  AlbumRepositoryImpl({
    required AlbumDataSource albumDataSource,
  }) : _albumDataSource = albumDataSource;

  @override
  Future<List<AlbumEntity>> getAlbums() async {
    final albums = await _albumDataSource.getAlbums();
    return albums
        .map((e) => AlbumEntity(
              name: e.name,
              thumbnail: e.thumbnail,
              photoCount: e.photoCount,
            ))
        .toList();
  }
}
