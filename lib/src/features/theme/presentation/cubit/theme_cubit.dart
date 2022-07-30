import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quran_app_clean_architecture/src/features/theme/domain/use_cases/fetch_theme_mode_use_case.dart';
import 'package:quran_app_clean_architecture/src/features/theme/domain/use_cases/toggle_theme_use_case.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final FetchThemeModeUseCase fetchThemeModeUseCase;
  final ToggleThemeUseCase toggleThemeUseCase;
  ThemeCubit({
    required this.fetchThemeModeUseCase,
    required this.toggleThemeUseCase,
  }) : super(ThemeInitial());

  void fetchThemeMode() async {
    final themMode = await fetchThemeModeUseCase();
    emit(LoadedThemeState(themeMode: themMode));
  }

  void toggleTheme({required ThemeMode themeMode}) async {
    emit(LoadedThemeState(themeMode: themeMode));
    toggleThemeUseCase(themeMode: themeMode);
  }
}
