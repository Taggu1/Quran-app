import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';
import '../entities/user_progress.dart';
import '../repositories/user_progress_repository.dart';

class FetchUserProgressDataUseCase {
  final UserProgressRepository repository;

  FetchUserProgressDataUseCase({required this.repository});

  Future<Either<Failure, UserProgress>> call({required AppUser appUser}) async {
    return await repository.fetchUserProgressData(appUser: appUser);
  }
}
