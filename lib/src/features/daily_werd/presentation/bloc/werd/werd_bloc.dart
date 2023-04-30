import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain/entities/werd.dart';
import '../../../domain/use_cases/fetch_werd_use_case.dart';

part 'werd_event.dart';
part 'werd_state.dart';

class WerdBloc extends Bloc<WerdEvent, WerdState> {
  final FetchWerdUseCase fetchWerdUseCase;

  WerdBloc({required this.fetchWerdUseCase})
      : super(const WerdState(
          Werd(
            isAudioPlaying: false,
            juz: 1,
            audio: null,
            ayahs: [],
            page: 1,
            surah: "s",
            hizab: 1,
            currentAyahPlaying: 0,
          ),
        )) {
    on<WerdEvent>((event, emit) async {
      if (event is FetchWerdEvent) {
        emit(LoadingWerdState(state.werd));

        final werdOrFailure = await fetchWerdUseCase();
        emit(_mapWerdOrFailureToWerdState(werdOrFailure));
      } else if (event is UpdateWerdPlayerIndexEvent) {
        final newAudio = event.werd.audio?..seek(null, index: event.index);
        final newWerd = event.werd.copyWith(audio: newAudio);
        emit(LoadedWerdState(newWerd));
      } else if (event is TogglePlayerPlayingStateEvent) {
        event.play ? state.werd.audio!.play() : state.werd.audio!.stop();

        emit(LoadedWerdState(state.werd.copyWith(isAudioPlaying: event.play)));
      }
    });
  }

  WerdState _mapWerdOrFailureToWerdState(
      Either<Failure, Werd> settingsOrFailure) {
    return settingsOrFailure.fold(
      (failure) =>
          FailureWerdState(message: mapFailureToMessage(failure), state.werd),
      (werd) => LoadedWerdState(werd),
    );
  }
}
