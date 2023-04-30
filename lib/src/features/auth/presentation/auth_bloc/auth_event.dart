part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class FetchUserFromStorageEvent extends AuthEvent {}

class LogInOrSignUpUserWithEmailAndPasswordEvent extends AuthEvent {
  final bool isLogin;
  final String email;
  final String password;

  const LogInOrSignUpUserWithEmailAndPasswordEvent({
    required this.isLogin,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [isLogin, email, password];
}

class LogInWithThirdPartyEvent extends AuthEvent {
  final ThirdParty thirdParty;

  const LogInWithThirdPartyEvent({required this.thirdParty});

  @override
  List<Object> get props => [thirdParty];
}

class LogInAsAGuestEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
