import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran_app_clean_architecture/l10n/l10n.dart';
import 'package:quran_app_clean_architecture/src/core/settings/settings_info.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final SettingsInfo settingsInfo;
  LocaleCubit({required this.settingsInfo})
      : super(LocaleInitial(locale: L10n.all.first));

  void setLocal(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    emit(LoadedLocalState(locale: locale));
  }

  void fetchLocal() {
    final locale = settingsInfo.settings!.appLanguage;

    emit(LoadedLocalState(locale: Locale(locale)));
  }

  void clearLocal() {
    emit(LocaleInitial(locale: L10n.all.last));
  }
}
