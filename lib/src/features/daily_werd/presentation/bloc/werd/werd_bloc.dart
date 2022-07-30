import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/domain/use_cases/fetch_werd_use_case.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain/entities/werd.dart';

part 'werd_event.dart';
part 'werd_state.dart';

class WerdBloc extends Bloc<WerdEvent, WerdState> {
  final FetchWerdUseCase fetchWerdUseCase;

  WerdBloc({required this.fetchWerdUseCase}) : super(WerdInitial()) {
    on<WerdEvent>((event, emit) async {
      if (event is FetchWerdEvent) {
        emit(LoadingWerdState());

        final werdOrFailure = await fetchWerdUseCase();
        emit(_mapWerdOrFailureToWerdState(werdOrFailure));
      }
    });
  }

  WerdState _mapWerdOrFailureToWerdState(
      Either<Failure, Werd> settingsOrFailure) {
    return settingsOrFailure.fold(
      (failure) => FailureWerdState(message: mapFailureToMessage(failure)),
      (werd) => LoadedWerdState(werd: werd),
    );
  }
}
