part of 'werd_bloc.dart';

abstract class WerdEvent extends Equatable {
  const WerdEvent();

  @override
  List<Object> get props => [];
}

class FetchWerdEvent extends WerdEvent {}
