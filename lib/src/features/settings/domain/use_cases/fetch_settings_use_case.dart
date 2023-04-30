import 'package:cloud_firestore_platform_interface/src/settings.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

class FetchSettingsUseCase {
  final SettingsRepository repository;

  FetchSettingsUseCase({required this.repository});

  Future<Either<Failure, UserSettings>> call() async {
    return await repository.fetchSettings();
  }
}
