import 'package:get_it/get_it.dart';
import 'package:photo_gallery/core/pegion/photo_gallery_api.dart';
import 'package:photo_gallery/data/data_source/album_data_source.dart';
import 'package:photo_gallery/data/data_source/photo_list_data_source.dart';
import 'package:photo_gallery/data/repository/album_repository_impl.dart';
import 'package:photo_gallery/data/repository/photo_list_repository_impl.dart';
import 'package:photo_gallery/domain/repository/album_repository.dart';
import 'package:photo_gallery/domain/repository/photo_list_repository.dart';
import 'package:photo_gallery/presentation/albums/cubits/albums_cubit.dart';
import 'package:photo_gallery/presentation/photos/cubits/photo_list_cubit.dart';

final sl = GetIt.I;

Future<void> setup() async {
  sl.registerLazySingleton(
    () => PhotoGalleryNativeHostApi(),
  );

  sl.registerLazySingleton(
    () => AlbumDataSource(photoGalleryNativeHostApi: sl.get()),
  );

  sl.registerLazySingleton<AlbumRepository>(
    () => AlbumRepositoryImpl(albumDataSource: sl.get()),
  );

  sl.registerFactory(() => AlbumsCubit(sl.get()));

  sl.registerLazySingleton(
    () => PhotoListDataSource(photoGalleryNativeHostApi: sl.get()),
  );

  sl.registerLazySingleton<PhotoListRepository>(
    () => PhotoListRepositoryImpl(dataSource: sl.get()),
  );

  sl.registerFactory(() => PhotoListCubit(sl.get()));
}
