part of 'werd_bloc.dart';

class WerdState extends Equatable {
  final Werd werd;
  const WerdState(this.werd);

  @override
  List<Object> get props => [werd];
}

class LoadingWerdState extends WerdState {
  const LoadingWerdState(super.werd);
}

class LoadedWerdState extends WerdState {
  const LoadedWerdState(super.werd);

  @override
  List<Object> get props => [werd];
}

class FailureWerdState extends WerdState {
  final String message;

  const FailureWerdState(super.werd, {required this.message});
  @override
  List<Object> get props => [message];
}
