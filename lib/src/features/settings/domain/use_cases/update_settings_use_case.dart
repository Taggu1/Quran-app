import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/settings_repository.dart';

class UpdateSettingWithKeyUseCase {
  final SettingsRepository repository;

  UpdateSettingWithKeyUseCase({required this.repository});

  Future<Either<Failure, bool>> call(
      {required String key, required dynamic setting}) async {
    return await repository.updateSettingWithKey(setting: setting, key: key);
  }
}
