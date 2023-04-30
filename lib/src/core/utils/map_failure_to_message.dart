import '../error/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    // TODO: TRANSILATION SUPPORT
    case EmptyCasheFailure:
      return "Data isn't availabale please connect to the internet";
    case ServerFailure:
      return "Couldn't load data from internet please try again";
    case OfflineFailure:
      return "You don't have an internet connection";
    case UnknownFailure:
      return "Something wrong happened please try again";
    default:
      return "Unknown error please try again later";
  }
}
