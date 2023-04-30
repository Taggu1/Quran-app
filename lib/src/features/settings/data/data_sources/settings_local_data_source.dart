import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/default_settings.dart';
import '../../../../core/constants/keys.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/settings.dart';

abstract class SettingsLocalDataSource {
  Future<UserSettings> fetchSettings();
  Future<bool> updateSettingWithKey(
      {required String key, required dynamic setting});
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<UserSettings> fetchSettings() async {
    UserSettings settings;
    final bool? thereIsSettings = sharedPreferences.getBool(isThereSettingsKey);
    if (thereIsSettings == null) {
      try {
        updateSettingsFromDefault(settings: defaultSettings);
      } on EmptyCasheException {
        rethrow;
      }
      settings = defaultSettings;
    } else {
      final UserSettings settingsToReturn = UserSettings(
        quranEdition: sharedPreferences.getString(quranEditionKey) ??
            defaultSettings.quranEdition,
        quranRecuter: sharedPreferences.getString(quranRecuterKey) ??
            defaultSettings.quranRecuter,
        ayahsCount: int.parse(sharedPreferences.getString(ayahsCountKey) ??
            defaultSettings.ayahsCount.toString()),
        appLanguage: sharedPreferences.getString(appLanguageKey) ??
            defaultSettings.appLanguage,
        isDarkTheme: sharedPreferences.getBool('theme-mode') ?? true,
      );
      print(settingsToReturn);
      settings = settingsToReturn;
    }

    return settings;
  }

  Future<Unit> updateSettingsFromDefault(
      {required UserSettings settings}) async {
    final response = await setSettings(settings);
    if (response != true) {
      throw EmptyCasheException();
    }
    await sharedPreferences.setBool(isThereSettingsKey, true);
    return unit;
  }

  Future<bool> setSettings(UserSettings settings) async {
    try {
      await sharedPreferences.setString(appLanguageKey, settings.appLanguage);
      await sharedPreferences.setString(quranEditionKey, settings.quranEdition);
      await sharedPreferences.setString(quranRecuterKey, settings.quranRecuter);
      await sharedPreferences.setString(
          ayahsCountKey, settings.ayahsCount.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateSettingWithKey(
      {required String key, required setting}) async {
    return await sharedPreferences.setString(key, setting);
  }
}
