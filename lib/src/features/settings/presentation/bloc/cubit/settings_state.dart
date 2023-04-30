part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final UserSettings settings;
  const SettingsState({required this.settings});
  @override
  List<Object> get props => [settings];
}

class LoadedSettingsState extends SettingsState {
  const LoadedSettingsState({required super.settings});
  @override
  List<Object> get props => [settings];
}

class FailureSettingsState extends SettingsState {
  final String message;
  const FailureSettingsState({required this.message, required super.settings});
  @override
  List<Object> get props => [message];
}

class LoadingSettingsState extends SettingsState {
  const LoadingSettingsState({required super.settings});
  @override
  List<Object> get props => [];
}
