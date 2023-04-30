import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repo.dart';

class SignOutUseCase {
  final AuthRepo repository;

  SignOutUseCase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.signOut();
  }
}
