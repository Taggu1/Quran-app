import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quran_app_clean_architecture/src/core/error/failures.dart';

abstract class ThemeRepository {
  Future<ThemeMode> fetchThemeMode();
  Future<Unit> toggleTheme({required ThemeMode themeMode});
}
