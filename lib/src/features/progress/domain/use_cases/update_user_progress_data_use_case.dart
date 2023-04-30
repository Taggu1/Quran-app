import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';
import '../../data/models/user_progress_model.dart';
import '../repositories/user_progress_repository.dart';

class UpdateUserProgressDataUseCase {
  final UserProgressRepository repository;

  UpdateUserProgressDataUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(
      {required AppUser appUser,
      required UserProgressModel userProgressData}) async {
    return await repository.updateUserProgressData(
      appUser: appUser,
      userProgressData: userProgressData,
    );
  }
}
