import 'package:dartz/dartz.dart';
import 'package:photo_gallery/core/error/error_message.dart';
import 'package:photo_gallery/core/error/exceptions.dart';
import 'package:photo_gallery/core/error/failures.dart';
import 'package:photo_gallery/data/data_source/photo_list_data_source.dart';
import 'package:photo_gallery/domain/entities/photo_entity.dart';
import 'package:photo_gallery/domain/repository/photo_list_repository.dart';

class PhotoListRepositoryImpl extends PhotoListRepository {
  final PhotoListDataSource _dataSource;

  PhotoListRepositoryImpl({
    required PhotoListDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<PhotoEntity>>> getPhotoList(String album) async {
    try {
      final photoList = await _dataSource.getPhotoList(album);
      return right(photoList.map((e) => PhotoEntity(path: e.path)).toList());
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
