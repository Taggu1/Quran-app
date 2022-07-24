import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/core/constants/default_settings.dart';
import 'package:quran_app_clean_architecture/src/core/error/exceptions.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/keys.dart';

abstract class SettingsLocalDataSource {
  Future<Settings> fetchSettings();
  Future<Unit> updateSettings({required Settings settings});
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  @override
  Future<Settings> fetchSettings() {
    // TODO: implement fetchSettings
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateSettings({required Settings settings}) {
    // TODO: implement updateSettings
    throw UnimplementedError();
  }
}
