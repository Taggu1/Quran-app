import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/repositories/settings_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/settings.dart';

class FetchSettingsUseCase {
  final SettingsRepository repository;

  FetchSettingsUseCase({required this.repository});

  Future<Either<Failure, Settings>> call() async {
    return await repository.fetchSettings();
  }
}
