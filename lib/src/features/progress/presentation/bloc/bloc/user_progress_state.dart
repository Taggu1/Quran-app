part of 'user_progress_bloc.dart';

abstract class UserProgressState extends Equatable {
  const UserProgressState();

  @override
  List<Object> get props => [];
}

class UserProgressInitial extends UserProgressState {}

class UserProgressLoadedState extends UserProgressState {
  final UserProgress userProgress;

  const UserProgressLoadedState({required this.userProgress});

  @override
  List<Object> get props => [userProgress];
}

class UserProgressLoadingState extends UserProgressState {}

class UserProgressErrorState extends UserProgressState {
  final String message;

  const UserProgressErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
