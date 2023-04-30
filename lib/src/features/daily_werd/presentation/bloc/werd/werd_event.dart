part of 'werd_bloc.dart';

abstract class WerdEvent extends Equatable {
  const WerdEvent();

  @override
  List<Object> get props => [];
}

class FetchWerdEvent extends WerdEvent {}

class UpdateWerdPlayerIndexEvent extends WerdEvent {
  final Werd werd;
  final int index;

  const UpdateWerdPlayerIndexEvent({required this.werd, required this.index});

  @override
  List<Object> get props => [werd, index];
}

class TogglePlayerPlayingStateEvent extends WerdEvent {
  final bool play;

  const TogglePlayerPlayingStateEvent({required this.play});

  @override
  List<Object> get props => [play];
}
