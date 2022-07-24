import 'package:quran_app_clean_architecture/src/core/error/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case EmptyCasheFailure:
      return "";
    case ServerFailure:
      return "";
    case OfflineFailure:
      return "";
    case UnknownFailure:
      return "";
    default:
      return "Unknown error please try again later";
  }
}
