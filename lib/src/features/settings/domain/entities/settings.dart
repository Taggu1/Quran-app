import 'package:equatable/equatable.dart';

class UserSettings extends Equatable {
  final String appLanguage;
  final String quranEdition;
  final String quranRecuter;
  final bool isDarkTheme;
  final int ayahsCount;

  const UserSettings({
    required this.isDarkTheme,
    required this.appLanguage,
    required this.ayahsCount,
    required this.quranEdition,
    required this.quranRecuter,
  });

  @override
  List<Object?> get props =>
      [quranEdition, quranRecuter, ayahsCount, appLanguage];
}
