abstract class Failure {}

class PhotoGalleryFailure extends Failure {
  final String failureMessage;

  PhotoGalleryFailure({
    required this.failureMessage,
  });
}
