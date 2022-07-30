import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/core/constants/default_settings.dart';
import 'package:quran_app_clean_architecture/src/core/error/exceptions.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/use_cases/update_settings_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/keys.dart';

abstract class SettingsLocalDataSource {
  Future<Settings> fetchSettings();
  Future<bool> updateSettingWithKey(
      {required String key, required dynamic setting});
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Settings> fetchSettings() async {
    final bool? thereIsSettings = sharedPreferences.getBool(isThereSettingsKey);
    if (thereIsSettings == null) {
      try {
        _updateSettingsFromDefault(settings: defaultSettings);
      } on EmptyCasheException {
        rethrow;
      }
      return defaultSettings;
    } else {
      final Settings settingsToReturn = Settings(
        quranEdition: sharedPreferences.getString(quranEditionKey)!,
        quranRecuter: sharedPreferences.getString(quranRecuterKey)!,
        ayahsCount: sharedPreferences.getInt(ayahsCountKey)!,
        appLanguage: sharedPreferences.getString(appLanguageKey)!,
      );
      return settingsToReturn;
    }
  }

  Future<Unit> _updateSettingsFromDefault({required Settings settings}) async {
    print("UpdateSettings");
    final response = await _setSettings(settings);
    if (response != true) {
      throw EmptyCasheException();
    }
    await sharedPreferences.setBool(isThereSettingsKey, true);
    return unit;
  }

  Future<bool> _setSettings(Settings settings) async {
    try {
      await sharedPreferences.setString(appLanguageKey, settings.appLanguage);
      await sharedPreferences.setString(quranEditionKey, settings.quranEdition);
      await sharedPreferences.setString(quranRecuterKey, settings.quranRecuter);
      await sharedPreferences.setInt(ayahsCountKey, settings.ayahsCount);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateSettingWithKey(
      {required String key, required setting}) async {
    final rspose = await sharedPreferences.setString(key, setting);
    print(rspose);

    return rspose;
  }
}
