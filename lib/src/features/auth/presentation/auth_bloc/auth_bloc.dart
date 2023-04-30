import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/map_failure_to_message.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../domain/use_cases/fetch_user_data_from_storage_use_case.dart';
import '../../domain/use_cases/log_in_user_with_third_party_use_case.dart';
import '../../domain/use_cases/sign_out_use_case.dart';
import '../../domain/use_cases/sign_up_or_login_as_a_guest_use_case.dart';
import '../../domain/use_cases/sign_up_or_login_with_email_and_password_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpOrLoginWithEmailAndPasswordUseCase
      signUpOrLoginWithEmailAndPasswordUseCase;
  final FetchUserDataFromSotrageUseCase fetchUserDataFromSotrageUseCase;
  final SignOutUseCase signOutUseCase;
  final SignUpOrLoginAsAGuestUseCase signUpOrLoginAsAGuestUseCase;
  final LogInUserWithThirdPartyUseCase logInUserWithThirdPartyUseCase;
  AuthBloc(
      {required this.signUpOrLoginWithEmailAndPasswordUseCase,
      required this.fetchUserDataFromSotrageUseCase,
      required this.signOutUseCase,
      required this.signUpOrLoginAsAGuestUseCase,
      required this.logInUserWithThirdPartyUseCase})
      : super(UnAuthState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LogInOrSignUpUserWithEmailAndPasswordEvent) {
        final userOrFailure = await signUpOrLoginWithEmailAndPasswordUseCase(
          password: event.password,
          email: event.email,
          isLogin: event.isLogin,
        );
        emit(_mapUserOrFailureToAuthState(userOrFailure: userOrFailure));
      } else if (event is LogInWithThirdPartyEvent) {
        final userOrFailure = await logInUserWithThirdPartyUseCase(
            thirdPartyType: event.thirdParty);

        emit(_mapUserOrFailureToAuthState(userOrFailure: userOrFailure));
      } else if (event is FetchUserFromStorageEvent) {
        final userOrFailure = await fetchUserDataFromSotrageUseCase();
        print("done");
        emit(_mapUserOrFailureToAuthState(userOrFailure: userOrFailure));
      } else if (event is SignOutEvent) {
        final unitOrFailure = await signOutUseCase();
        emit(UnAuthState());
      }
    });
  }

  AuthState _mapUserOrFailureToAuthState(
      {required Either<Failure, AppUser> userOrFailure}) {
    return userOrFailure.fold((failure) {
      if (failure is FirebaseAuthFaliure) {
        return FailedToAuthState(message: failure.message);
      } else {
        return FailedToAuthState(message: mapFailureToMessage(failure));
      }
    }, (user) => AuthedState(appUser: user));
  }
}
