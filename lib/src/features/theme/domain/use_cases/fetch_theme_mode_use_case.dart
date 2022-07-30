import 'package:flutter/material.dart';
import 'package:quran_app_clean_architecture/src/features/theme/domain/repositories/themeRepository.dart';

class FetchThemeModeUseCase {
  final ThemeRepository repository;

  FetchThemeModeUseCase({required this.repository});

  Future<ThemeMode> call() async {
    return await repository.fetchThemeMode();
  }
}
