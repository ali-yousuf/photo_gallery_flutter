import 'package:photo_gallery/core/error/failures.dart';

class FailureToMessageConverter {
  static String convert(Failure failure) {
    if (failure is PhotoGalleryFailure) {
      return failure.failureMessage;
    }
    return 'Unexpected error';
  }
}
