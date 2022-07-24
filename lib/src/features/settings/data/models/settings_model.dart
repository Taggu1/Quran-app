import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';

class SettingsModel extends Settings {
  SettingsModel(
      {required super.quranEdition,
      required super.quranRecuter,
      required super.ayahsCount,
      required super.appLanguage,
      required super.isDarkMode});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
        quranEdition: json["quranEdition"],
        quranRecuter: json["quranRecuter"],
        ayahsCount: json["ayahsCount"],
        appLanguage: json["appLanguage"],
        isDarkMode: json["isDarkMode"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "quranEdition": quranEdition,
      "quranRecuter": quranRecuter,
      "ayahsCount": ayahsCount,
      "appLanguage": appLanguage,
      "isDarkMode": isDarkMode
    };
  }
}
