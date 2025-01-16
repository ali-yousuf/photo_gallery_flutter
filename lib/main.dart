import 'package:flutter/material.dart';
import 'package:photo_gallery/app/photo_gallery_app.dart';
import 'package:photo_gallery/core/di/service_locator.dart';

Future<void> main() async {
  await setup();
  runApp(const PhotoGalleryApp());
}
