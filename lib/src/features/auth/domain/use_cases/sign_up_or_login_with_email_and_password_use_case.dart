import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repo.dart';

class SignUpOrLoginWithEmailAndPasswordUseCase {
  final AuthRepo repository;

  SignUpOrLoginWithEmailAndPasswordUseCase({required this.repository});

  Future<Either<Failure, AppUser>> call({
    required String email,
    required String password,
    required bool isLogin,
  }) async {
    return await repository.signUpOrLoginWithEmailAndPassword(
      email: email,
      password: password,
      isLogin: isLogin,
    );
  }
}
