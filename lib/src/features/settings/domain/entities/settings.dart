import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final String appLanguage;
  final String quranEdition;
  final String quranRecuter;
  final int ayahsCount;

  const Settings({
    required this.appLanguage,
    required this.ayahsCount,
    required this.quranEdition,
    required this.quranRecuter,
  });

  @override
  List<Object?> get props =>
      [quranEdition, quranRecuter, ayahsCount, appLanguage];
}
