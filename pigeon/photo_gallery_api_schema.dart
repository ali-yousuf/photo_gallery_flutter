import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/core/pegion/photo_gallery_api.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/app/src/main/kotlin/com/example/photo_gallery/pegion/PhotoGalleryApi.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/PhotoGalleryApi.swift',
  swiftOptions: SwiftOptions(),
))
class Album {
  final String name;
  final String thumbnail;
  final int photoCount;

  Album({
    required this.name,
    required this.thumbnail,
    required this.photoCount,
  });
}

@HostApi()
abstract class PhotoGalleryNativeHostApi {
  List<Album> getAlbums();
}
