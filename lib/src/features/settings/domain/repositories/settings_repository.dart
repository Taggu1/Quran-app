import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/core/error/failures.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, Settings>> fetchSettings();
  Future<Either<Failure, bool>> updateSettingWithKey(
      {required String key, required dynamic setting});
}
