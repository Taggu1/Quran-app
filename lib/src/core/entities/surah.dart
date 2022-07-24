import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int number;
  final String name;
  final String revelationType;
  final int numberOfAyahs;

  const Surah({
    required this.number,
    required this.name,
    required this.revelationType,
    required this.numberOfAyahs,
  });

  @override
  List<Object?> get props => [number, name, revelationType, numberOfAyahs];
}
