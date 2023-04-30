import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/user_progress.dart';
import '../../domain/repositories/user_progress_repository.dart';
import '../data_sources/user_progress_remote_data_source.dart';
import '../models/user_progress_model.dart';

class UserProgressRepositoryImpl extends UserProgressRepository {
  final UserProgressRemoteDataSource userProgressRemoteDataSource;

  UserProgressRepositoryImpl({required this.userProgressRemoteDataSource});
  @override
  Future<Either<Failure, UserProgress>> fetchUserProgressData(
      {required AppUser appUser}) async {
    try {
      final userProgress = await userProgressRemoteDataSource.fetchUserProgress(
          appUser: appUser);
      return Right(userProgress);
    } on ServerExciption {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserProgressData(
      {required AppUser appUser,
      required UserProgressModel userProgressData}) async {
    try {
      final response = await userProgressRemoteDataSource.updateUserProgress(
          appUser: appUser, userProgressData: userProgressData);
      return Right(response);
    } on ServerExciption {
      return Left(ServerFailure());
    }
  }
}
