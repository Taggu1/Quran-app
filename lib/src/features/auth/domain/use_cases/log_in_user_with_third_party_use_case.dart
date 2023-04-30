import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repo.dart';

class LogInUserWithThirdPartyUseCase {
  final AuthRepo repository;

  LogInUserWithThirdPartyUseCase({required this.repository});

  Future<Either<Failure, AppUser>> call({
    required ThirdParty thirdPartyType,
  }) async {
    return await repository.logInUserWithThirdParty(
        thirdPartyType: thirdPartyType);
  }
}
