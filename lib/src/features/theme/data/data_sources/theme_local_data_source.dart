import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quran_app_clean_architecture/src/core/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<ThemeMode> fetchThemeMode();
  Future<Unit> toggleTheme({required ThemeMode themeMode});
}

class ThemeLocalDataSourceImpl extends ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<ThemeMode> fetchThemeMode() async {
    final cashedThemeMode = sharedPreferences.getString(isDarkModeKey);
    if (cashedThemeMode == null) {
      await sharedPreferences.setString(isDarkModeKey, 'true');
      return ThemeMode.dark;
    } else {
      if (cashedThemeMode.toLowerCase() == 'true') {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    }
  }

  @override
  Future<Unit> toggleTheme({required ThemeMode themeMode}) {
    if (themeMode == ThemeMode.dark) {
      sharedPreferences.setString(isDarkModeKey, 'true');
    } else {
      sharedPreferences.setString(isDarkModeKey, 'false');
    }
    return Future.value(unit);
  }
}
