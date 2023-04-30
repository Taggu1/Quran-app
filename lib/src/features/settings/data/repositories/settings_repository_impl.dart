import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../data_sources/settings_local_data_source.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsLocalDataSource settingsLocalDataSource;

  SettingsRepositoryImpl({
    required this.settingsLocalDataSource,
  });
  @override
  Future<Either<Failure, UserSettings>> fetchSettings() async {
    try {
      final settings = await settingsLocalDataSource.fetchSettings();
      return Right(settings);
    } on EmptyCasheException {
      return Left(
        EmptyCasheFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> updateSettingWithKey(
      {required String key, required setting}) async {
    try {
      final response = await settingsLocalDataSource.updateSettingWithKey(
          key: key, setting: setting);
      return Right(response);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
