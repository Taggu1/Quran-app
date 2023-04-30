abstract class Failure {}

class ServerFailure extends Failure {}

class EmptyCasheFailure extends Failure {}

class OfflineFailure extends Failure {}

class UnknownFailure extends Failure {}

class FirebaseAuthFaliure extends Failure {
  final String message;

  FirebaseAuthFaliure({required this.message});
}
