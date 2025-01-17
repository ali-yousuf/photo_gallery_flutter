abstract class ErrorMessageProvider {
  String getErrorMessage(String code);
}

class PhotoGalleryErrorMessageProvider implements ErrorMessageProvider {
  final Map<String, String> _errorMessages = {
    "ALBUM_NOT_FOUND": "The requested album could not be found.",
    "EMPTY_ALBUM": "The album is empty.",
    "PHOTO_ACCESS_DENIED": "Permission to access photos was denied.",
    "INVALID_ALBUM_NAME": "The album name is invalid.",
    "STORAGE_UNAVAILABLE": "Storage is unavailable. Please try again later.",
    "MEDIA_STORE_ERROR": "An error occurred while accessing the media store.",
    "IO_ERROR": "An I/O error occurred. Please try again.",
    "PHOTO_NOT_FOUND": "The requested photo could not be found.",
    "FORMAT_UNSUPPORTED": "The photo format is not supported.",
  };

  @override
  String getErrorMessage(String code) {
    return _errorMessages[code] ?? "An unknown error occurred. Please try again.";
  }
}

class ErrorMessageFactory {
  static final ErrorMessageProvider _provider = PhotoGalleryErrorMessageProvider();

  static String getErrorMessage(String code) {
    return _provider.getErrorMessage(code);
  }
}
