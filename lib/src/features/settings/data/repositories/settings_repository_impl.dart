import 'package:quran_app_clean_architecture/src/core/error/exceptions.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';
import 'package:quran_app_clean_architecture/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/repositories/settings_repository.dart';

import '../data_sources/settings_local_data_source.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsLocalDataSource settingsLocalDataSource;

  SettingsRepositoryImpl({
    required this.settingsLocalDataSource,
  });
  @override
  Future<Either<Failure, Settings>> fetchSettings() async {
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
  Future<Either<Failure, Unit>> updateSettings(Settings settings) async {
    try {
      await settingsLocalDataSource.updateSettings(settings: settings);
      return const Right(unit);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
