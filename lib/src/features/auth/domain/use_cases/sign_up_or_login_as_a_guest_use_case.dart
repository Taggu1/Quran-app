import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repo.dart';

class SignUpOrLoginAsAGuestUseCase {
  final AuthRepo repository;

  SignUpOrLoginAsAGuestUseCase({required this.repository});

  Future<Either<Failure, AppUser>> call() async {
    return await repository.signUpOrLoginAsAGuest();
  }
}
