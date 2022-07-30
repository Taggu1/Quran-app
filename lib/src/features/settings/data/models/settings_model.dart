import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel({
    required super.quranEdition,
    required super.quranRecuter,
    required super.ayahsCount,
    required super.appLanguage,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      quranEdition: json["quranEdition"],
      quranRecuter: json["quranRecuter"],
      ayahsCount: json["ayahsCount"],
      appLanguage: json["appLanguage"],
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
