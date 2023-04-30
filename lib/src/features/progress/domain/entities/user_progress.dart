import 'package:equatable/equatable.dart';

class UserProgress extends Equatable {
  final int daysStreak;
  final int totalDays;

  const UserProgress({required this.daysStreak, required this.totalDays});

  @override
  List<Object?> get props => [daysStreak, totalDays];
}
