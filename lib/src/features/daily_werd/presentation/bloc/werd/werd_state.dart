part of 'werd_bloc.dart';

abstract class WerdState extends Equatable {
  const WerdState();

  @override
  List<Object> get props => [];
}

class WerdInitial extends WerdState {}

class LoadingWerdState extends WerdState {}

class LoadedWerdState extends WerdState {
  final Werd werd;

  const LoadedWerdState({required this.werd});

  @override
  List<Object> get props => [werd];
}

class FailureWerdState extends WerdState {
  final String message;

  const FailureWerdState({required this.message});

  @override
  List<Object> get props => [message];
}
