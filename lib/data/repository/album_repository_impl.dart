import 'package:dartz/dartz.dart';
import 'package:photo_gallery/core/error/error_message.dart';
import 'package:photo_gallery/core/error/exceptions.dart';
import 'package:photo_gallery/core/error/failures.dart';
import 'package:photo_gallery/data/data_source/album_data_source.dart';
import 'package:photo_gallery/domain/entities/album_entity.dart';
import 'package:photo_gallery/domain/repository/album_repository.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final AlbumDataSource _albumDataSource;

  AlbumRepositoryImpl({
    required AlbumDataSource albumDataSource,
  }) : _albumDataSource = albumDataSource;

  @override
  Future<Either<Failure, List<AlbumEntity>>> getAlbums() async {
    try {
      final albums = await _albumDataSource.getAlbums();
      return Right(
        albums
            .map((e) => AlbumEntity(
                  name: e.name,
                  thumbnail: e.thumbnail,
                  photoCount: e.photoCount,
                ))
            .toList(),
      );
    } on PhotoGalleryException catch (e) {
      return Left(
        PhotoGalleryFailure(
          failureMessage: ErrorMessageFactory.getErrorMessage(
            e.code,
          ),
        ),
      );
    } catch (e) {
      return Left(
        PhotoGalleryFailure(
          failureMessage: ErrorMessageFactory.getErrorMessage(
            e.toString(),
          ),
        ),
      );
    }
  }
}
