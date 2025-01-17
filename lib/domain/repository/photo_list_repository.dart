import 'package:dartz/dartz.dart';
import 'package:photo_gallery/core/error/failures.dart';
import 'package:photo_gallery/domain/entities/photo_entity.dart';

abstract class PhotoListRepository {
  Future<Either<Failure, List<PhotoEntity>>> getPhotoList(
    String album,
  );
}
