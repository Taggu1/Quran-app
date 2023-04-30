part of 'user_progress_bloc.dart';

abstract class UserProgressEvent extends Equatable {
  const UserProgressEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProgressEvent extends UserProgressEvent {
  final AppUser appUser;

  const FetchUserProgressEvent({required this.appUser});

  @override
  List<Object> get props => [appUser];
}

class UpdateUserProgressEvent extends UserProgressEvent {
  final UserProgressModel userProgress;
  final AppUser appUser;

  const UpdateUserProgressEvent({
    required this.userProgress,
    required this.appUser,
  });

  @override
  List<Object> get props => [userProgress];
}
