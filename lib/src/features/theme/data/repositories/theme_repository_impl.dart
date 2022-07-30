import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quran_app_clean_architecture/src/features/theme/data/data_sources/theme_local_data_source.dart';
import 'package:quran_app_clean_architecture/src/features/theme/domain/repositories/themeRepository.dart';

class ThemeRepositoryImpl extends ThemeRepository {
  final ThemeLocalDataSource themeLocalDataSource;

  ThemeRepositoryImpl({required this.themeLocalDataSource});
  @override
  Future<ThemeMode> fetchThemeMode() async {
    return themeLocalDataSource.fetchThemeMode();
  }

  @override
  Future<Unit> toggleTheme({required ThemeMode themeMode}) {
    return themeLocalDataSource.toggleTheme(themeMode: themeMode);
  }
}
