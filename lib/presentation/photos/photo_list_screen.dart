import 'package:flutter/material.dart';
import 'package:photo_gallery/core/di/service_locator.dart';
import 'package:photo_gallery/presentation/photos/cubits/photo_list_cubit.dart';
import 'package:photo_gallery/presentation/photos/widgets/photo_grid_view.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({super.key, required this.album});

  final String album;

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  final PhotoListCubit _photoListCubit = sl.get();

  @override
  void initState() {
    super.initState();
    _photoListCubit.loadPhotoList(widget.album);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.album),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: PhotoGridView(photoListCubit: _photoListCubit),
    );
  }

  @override
  void dispose() {
    _photoListCubit.close();
    super.dispose();
  }
}
