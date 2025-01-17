import 'package:dartz/dartz.dart';
import 'package:photo_gallery/core/error/failures.dart';
import 'package:photo_gallery/domain/entities/album_entity.dart';

abstract class AlbumRepository {
  Future<Either<Failure, List<AlbumEntity>>> getAlbums();
}
