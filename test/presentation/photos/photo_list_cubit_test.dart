import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/core/error/failures.dart';
import 'package:photo_gallery/domain/entities/photo_entity.dart';
import 'package:photo_gallery/domain/repository/photo_list_repository.dart';
import 'package:photo_gallery/presentation/photos/cubits/photo_list_cubit.dart';

import 'photo_list_cubit_test.mocks.dart';

@GenerateMocks([PhotoListRepository])
void main() {
  late MockPhotoListRepository mockPhotoListRepository;
  late PhotoListCubit photoListCubit;

  final List<PhotoEntity> mockPhotos = [
    PhotoEntity(path: 'photo1.jpg'),
    PhotoEntity(path: 'photo2.jpg'),
  ];

  setUp(() {
    mockPhotoListRepository = MockPhotoListRepository();
    photoListCubit = PhotoListCubit(mockPhotoListRepository);
  });

  tearDown(() {
    photoListCubit.close();
  });

  group('PhotoListCubit', () {
    test('initial state should be PhotoListInitial', () {
      expect(photoListCubit.state, PhotoListInitial());
    });

    blocTest<PhotoListCubit, PhotoListState>(
      'emits [PhotoListLoading, PhotoListLoaded] when loadPhotoList succeeds and photos are found',
      build: () => photoListCubit,
      setUp: () {
        when(mockPhotoListRepository.getPhotoList(any)).thenAnswer(
          (_) async => Right(mockPhotos),
        );
      },
      act: (cubit) => cubit.loadPhotoList('album1'),
      expect: () => [
        PhotoListLoading(),
        PhotoListLoaded(photoList: mockPhotos),
      ],
      verify: (cubit) {
        verify(mockPhotoListRepository.getPhotoList('album1')).called(1);
      },
    );

    blocTest<PhotoListCubit, PhotoListState>(
      'emits [PhotoListLoading, NoPhotoFound] when loadPhotoList succeeds but no photos are found',
      build: () => photoListCubit,
      setUp: () {
        when(mockPhotoListRepository.getPhotoList(any)).thenAnswer(
          (_) async => const Right([]),
        );
      },
      act: (cubit) => cubit.loadPhotoList('album1'),
      expect: () => [
        PhotoListLoading(),
        NoPhotoFound(),
      ],
      verify: (cubit) {
        verify(mockPhotoListRepository.getPhotoList('album1')).called(1);
      },
    );

    blocTest<PhotoListCubit, PhotoListState>(
      'emits [PhotoListLoading, PhotoListFailure] when loadPhotoList fails',
      build: () => photoListCubit,
      setUp: () {
        when(mockPhotoListRepository.getPhotoList(any)).thenAnswer(
          (_) async => Left(
            PhotoGalleryFailure(failureMessage: 'Error fetching photos'),
          ),
        );
      },
      act: (cubit) => cubit.loadPhotoList('album1'),
      expect: () => [
        PhotoListLoading(),
        const PhotoListFailure('Error fetching photos'),
      ],
      verify: (cubit) {
        verify(mockPhotoListRepository.getPhotoList('album1')).called(1);
      },
    );
  });
}
