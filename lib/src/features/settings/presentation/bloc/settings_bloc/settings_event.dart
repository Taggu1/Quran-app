part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class UpdateSettingsEvent extends SettingsEvent {
  final Settings settings;

  const UpdateSettingsEvent({
    required this.settings,
  });

  @override
  List<Object> get props => [settings];
}
