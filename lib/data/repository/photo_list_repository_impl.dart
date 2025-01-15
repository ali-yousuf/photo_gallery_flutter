import 'package:photo_gallery/data/data_source/photo_list_data_source.dart';
import 'package:photo_gallery/domain/entities/photo_entity.dart';
import 'package:photo_gallery/domain/repository/photo_list_repository.dart';

class PhotoListRepositoryImpl extends PhotoListRepository {
  final PhotoListDataSource _dataSource;

  PhotoListRepositoryImpl({
    required PhotoListDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<List<PhotoEntity>> getPhotoList(String album) async {
    final photoList = await _dataSource.getPhotoList(album);
    return photoList.map((e) => PhotoEntity(path: e.path)).toList();
  }
}
