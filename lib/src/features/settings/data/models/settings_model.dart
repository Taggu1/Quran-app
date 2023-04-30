import '../../domain/entities/settings.dart';

class SettingsModel extends UserSettings {
  const SettingsModel(
      {required super.quranEdition,
      required super.quranRecuter,
      required super.ayahsCount,
      required super.appLanguage,
      required super.isDarkTheme});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      quranEdition: json["quranEdition"],
      quranRecuter: json["quranRecuter"],
      ayahsCount: json["ayahsCount"],
      appLanguage: json["appLanguage"],
      isDarkTheme: json['darkTheme'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "quranEdition": quranEdition,
      "quranRecuter": quranRecuter,
      "ayahsCount": ayahsCount,
      "appLanguage": appLanguage,
    };
  }
}
