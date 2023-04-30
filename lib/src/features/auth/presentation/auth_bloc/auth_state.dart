part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UnAuthState extends AuthState {}

class AuthedState extends AuthState {
  final AppUser appUser;

  const AuthedState({required this.appUser});

  @override
  List<Object> get props => [appUser];
}

class FailedToAuthState extends AuthState {
  final String message;

  const FailedToAuthState({required this.message});

  @override
  List<Object> get props => [message];
}
