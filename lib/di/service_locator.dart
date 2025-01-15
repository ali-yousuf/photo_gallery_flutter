import 'package:get_it/get_it.dart';
import 'package:photo_gallery/core/pegion/photo_gallery_api.dart';
import 'package:photo_gallery/data/data_source/alubms_data_source.dart';
import 'package:photo_gallery/data/repository/AlbumRepositoryImpl.dart';
import 'package:photo_gallery/domain/repository/album_repository.dart';
import 'package:photo_gallery/presentation/albums/cubits/albums_cubit.dart';

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
}
