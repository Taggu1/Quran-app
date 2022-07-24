import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/settings/domain/entities/settings.dart';
import '../constants/default_settings.dart';
import '../constants/keys.dart';
import '../error/exceptions.dart';

class SettingsInfo {
  final SharedPreferences sharedPreferences;
  Settings? settings;

  SettingsInfo({required this.sharedPreferences});

  Future<void> fetchSettings() async {
    final bool? thereIsSettings = sharedPreferences.getBool(isThereSettingsKey);
    if (thereIsSettings == null) {
      try {
        updateSettingsFromDefault(settings: defaultSettings);
      } on EmptyCasheException {
        rethrow;
      }
      settings = defaultSettings;
    } else {
      print("fromSotrage");

      final Settings settingsToReturn = Settings(
        quranEdition: sharedPreferences.getString(quranEditionKey)!,
        quranRecuter: sharedPreferences.getString(quranRecuterKey)!,
        ayahsCount: sharedPreferences.getInt(ayahsCountKey)!,
        appLanguage: sharedPreferences.getString(appLanguageKey)!,
        isDarkMode: sharedPreferences.getBool(isDarkModeKey)!,
      );
      print(settingsToReturn);
      settings = settingsToReturn;
    }
  }

  Future<void> updateOneSettingWithKey(String key, value) async {
    sharedPreferences.setString(key, value);
    fetchSettings();
  }

  Future<Unit> updateSettingsFromDefault({required Settings settings}) async {
    print("UpdateSettings");
    final response = await setSettings(settings);
    if (response != true) {
      throw EmptyCasheException();
    }
    await sharedPreferences.setBool(isThereSettingsKey, true);
    return unit;
  }

  Future<bool> setSettings(Settings settings) async {
    try {
      await sharedPreferences.setBool(isDarkModeKey, settings.isDarkMode);
      await sharedPreferences.setString(appLanguageKey, settings.appLanguage);
      await sharedPreferences.setString(quranEditionKey, settings.quranEdition);
      await sharedPreferences.setString(quranRecuterKey, settings.quranRecuter);
      await sharedPreferences.setInt(ayahsCountKey, settings.ayahsCount);
      return true;
    } catch (e) {
      return false;
    }
  }
}
