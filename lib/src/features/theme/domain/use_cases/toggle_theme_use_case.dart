import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quran_app_clean_architecture/src/features/theme/domain/repositories/themeRepository.dart';

class ToggleThemeUseCase {
  final ThemeRepository themeRepository;

  ToggleThemeUseCase({required this.themeRepository});

  Future<Unit> call({required ThemeMode themeMode}) async {
    return await themeRepository.toggleTheme(themeMode: themeMode);
  }
}
