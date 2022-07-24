import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/core/entities/ayah.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/repositories/settings_repository.dart';

import '../../../../core/error/failures.dart';

class UpdateSettingsUseCase {
  final SettingsRepository repository;

  UpdateSettingsUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Settings settings) async {
    return await repository.updateSettings(settings);
  }
}
