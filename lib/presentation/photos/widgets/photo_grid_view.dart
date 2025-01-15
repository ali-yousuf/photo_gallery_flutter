import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/domain/entities/photo_entity.dart';
import 'package:photo_gallery/presentation/photos/cubits/photo_list_cubit.dart';
import 'package:photo_gallery/presentation/widgets/no_data_found.dart';
import 'package:photo_gallery/presentation/widgets/progress_loader.dart';

class PhotoGridView extends StatelessWidget {
  const PhotoGridView({
    super.key,
    required this.photoListCubit,
  });

  final PhotoListCubit photoListCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoListCubit, PhotoListState>(
      bloc: photoListCubit,
      builder: (context, state) {
        if (state is PhotoListLoading) {
          return const ProgressLoader();
        } else if (state is PhotoListLoaded) {
          return _buildPhotoGridView(state.photoList);
        }
        return const NoDataFound();
      },
    );
  }

  Widget _buildPhotoGridView(List<PhotoEntity> photoList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      padding: const EdgeInsets.all(12),
      itemCount: photoList.length,
      itemBuilder: (context, index) {
        return _PhotoCard(photoEntity: photoList[index]);
      },
    );
  }
}

class _PhotoCard extends StatelessWidget {
  const _PhotoCard({
    required this.photoEntity,
  });

  final PhotoEntity photoEntity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.file(
        key: ValueKey(photoEntity.path),
        File(photoEntity.path),
        fit: BoxFit.cover,
        cacheWidth: 200,
        cacheHeight: 200,
      ),
    );
  }
}
