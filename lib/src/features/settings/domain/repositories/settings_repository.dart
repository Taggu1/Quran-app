import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, UserSettings>> fetchSettings();
  Future<Either<Failure, bool>> updateSettingWithKey(
      {required String key, required dynamic setting});
}
