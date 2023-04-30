import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repo.dart';

class FetchUserDataFromSotrageUseCase {
  final AuthRepo repository;

  FetchUserDataFromSotrageUseCase({required this.repository});

  Future<Either<Failure, AppUser>> call() async {
    return await repository.fetchUserDataFromStorage();
  }
}
