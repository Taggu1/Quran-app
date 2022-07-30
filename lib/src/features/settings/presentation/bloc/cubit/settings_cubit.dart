// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../../core/constants/default_settings.dart';
// import '../../../../../core/error/failures.dart';
// import '../../../../../core/utils/map_failure_to_message.dart';
// import '../../../domain/entities/settings.dart';
// import '../../../domain/use_cases/fetch_settings_use_case.dart';
// import '../../../domain/use_cases/update_settings_use_case.dart';

// part 'settings_state.dart';

// class SettingsCubit extends Cubit<SettingsState> {
//   final FetchSettingsUseCase fetchSettingsUseCase;
//   final UpdateSettingWithKeyUseCase updateSettingWithKeyUseCase;
//   SettingsCubit(
//       {required this.fetchSettingsUseCase,
//       required this.updateSettingWithKeyUseCase})
//       : super(const SettingsInitial(settings: defaultSettings));

//   Future<void> fetchSettings() async {
//     final settingsOrFailure = await fetchSettingsUseCase();

//     emit(_mapSettingsOrFailureToSettingsState(settingsOrFailure));
//   }

//   Future<void> updateOneSettingWithKey({
//     required String key,
//     required dynamic value,
//   }) async {
//     print(state);
//     emit(LoadingSettingsState());
//     final isUpdated =
//         await updateSettingWithKeyUseCase(key: key, setting: value);

//     final settingsOrFailure = await fetchSettingsUseCase();

//     emit(_mapSettingsOrFailureToSettingsState(settingsOrFailure));
//     print(state);
//   }

//   SettingsState _mapSettingsOrFailureToSettingsState(
//       Either<Failure, Settings> settingsOrFailure) {
//     return settingsOrFailure.fold(
//       (failure) => FailureSettingsState(message: mapFailureToMessage(failure)),
//       (settings) {
//         print(settings);
//         print("s");
//         return LoadedSettingsState(settings: settings);
//       },
//     );
//   }
// }
