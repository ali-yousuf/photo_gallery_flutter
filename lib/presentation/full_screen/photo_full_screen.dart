import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_gallery/app/app_colors.dart';
import 'package:photo_view/photo_view.dart';

class PhotoFullScreen extends StatelessWidget {
  const PhotoFullScreen({
    super.key,
    required this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: AppColors.white),
        ),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: FileImage(File(path)),
        ),
      ),
    );
  }
}
