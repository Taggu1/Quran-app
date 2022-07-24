part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final Settings settings;
  const SettingsState({required this.settings});

  @override
  List<Object> get props => [settings];
}

class SettingsInitial extends SettingsState {
  SettingsInitial({required super.settings});
}

class LoadedSettingsState extends SettingsState {
  LoadedSettingsState({required super.settings});
}

class FailureSettingsState extends SettingsState {
  final String message;

  const FailureSettingsState({required this.message, required super.settings});

  @override
  List<Object> get props => [message, settings];
}

class LoadingSettingsEvent extends SettingsState {
  LoadingSettingsEvent({required super.settings});
}
