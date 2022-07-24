import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran_app_clean_architecture/src/core/error/failures.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, Settings>> fetchSettings();
  Future<Either<Failure, Unit>> updateSettings(Settings settings);
}
