import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

enum ThirdParty {
  google,
  facebook,
  apple,
}

abstract class AuthRepo {
  Future<Either<Failure, AppUser>> logInUserWithThirdParty(
      {required ThirdParty thirdPartyType});

  Future<Either<Failure, AppUser>> signUpOrLoginWithEmailAndPassword({
    required String email,
    required String password,
    required bool isLogin,
  });

  Future<Either<Failure, AppUser>> signUpOrLoginAsAGuest();

  Future<Either<Failure, AppUser>> fetchUserDataFromStorage();

  Future<Either<Failure, Unit>> signOut();
}
