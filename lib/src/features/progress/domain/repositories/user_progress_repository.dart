import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';
import '../../data/models/user_progress_model.dart';
import '../entities/user_progress.dart';

abstract class UserProgressRepository {
  Future<Either<Failure, UserProgress>> fetchUserProgressData(
      {required AppUser appUser});

  Future<Either<Failure, Unit>> updateUserProgressData({
    required AppUser appUser,
    required UserProgressModel userProgressData,
  });
}
