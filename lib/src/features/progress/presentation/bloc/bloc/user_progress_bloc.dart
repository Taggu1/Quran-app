import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../../auth/domain/entities/user.dart';
import '../../../data/models/user_progress_model.dart';
import '../../../domain/entities/user_progress.dart';
import '../../../domain/use_cases/fetch_user_progress_data_use_case.dart';
import '../../../domain/use_cases/update_user_progress_data_use_case.dart';

part 'user_progress_event.dart';
part 'user_progress_state.dart';

class UserProgressBloc extends Bloc<UserProgressEvent, UserProgressState> {
  final UpdateUserProgressDataUseCase updateUserProgressDataUseCase;
  final FetchUserProgressDataUseCase fetchUserProgressDataUseCase;
  UserProgressBloc({
    required this.fetchUserProgressDataUseCase,
    required this.updateUserProgressDataUseCase,
  }) : super(UserProgressInitial()) {
    on<UserProgressEvent>((event, emit) async {
      if (event is FetchUserProgressEvent) {
        emit(UserProgressLoadingState());
        final userProgressOrFailure =
            await fetchUserProgressDataUseCase(appUser: event.appUser);

        emit(_mapUserOrFailureToUserProgressState(
            userProgressOrFailure: userProgressOrFailure));
      } else if (event is UpdateUserProgressEvent) {}
    });
  }

  UserProgressState _mapUserOrFailureToUserProgressState(
      {required Either<Failure, UserProgress> userProgressOrFailure}) {
    return userProgressOrFailure.fold(
        (failure) =>
            UserProgressErrorState(message: mapFailureToMessage(failure)),
        (user) => UserProgressLoadedState(userProgress: user));
  }
}
