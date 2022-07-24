import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_app_clean_architecture/src/core/constants/default_settings.dart';
import 'package:quran_app_clean_architecture/src/core/utils/map_failure_to_message.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/use_cases/fetch_settings_use_case.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/use_cases/update_settings_use_case.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final FetchSettingsUseCase fetchSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;
  SettingsBloc(
      {required this.fetchSettingsUseCase, required this.updateSettingsUseCase})
      : super(SettingsInitial(settings: defaultSettings)) {
    print("inited");
    on<SettingsEvent>((event, emit) async {
      if (event is LoadSettingsEvent) {
        final settingsOrFailure = await fetchSettingsUseCase();
        emit(_mapSettingsOrFailureToSettingsState(settingsOrFailure));
      } else if (event is UpdateSettingsEvent) {
        emit(LoadedSettingsState(settings: event.settings));
        await updateSettingsUseCase(event.settings);
        // TODO:Check for failures
      }
    });
  }

  SettingsState _mapSettingsOrFailureToSettingsState(
      Either<Failure, Settings> settingsOrFailure) {
    return settingsOrFailure.fold(
      (failure) => FailureSettingsState(
          message: mapFailureToMessage(failure), settings: defaultSettings),
      (settings) => LoadedSettingsState(settings: settings),
    );
  }
}
