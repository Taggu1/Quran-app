import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/repositories/settings_repository.dart';

import '../../../../core/error/failures.dart';

class UpdateSettingWithKeyUseCase {
  final SettingsRepository repository;

  UpdateSettingWithKeyUseCase({required this.repository});

  Future<Either<Failure, bool>> call(
      {required String key, required dynamic setting}) async {
    return await repository.updateSettingWithKey(setting: setting, key: key);
  }
}
