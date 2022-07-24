import 'package:quran_app_clean_architecture/src/core/entities/surah.dart';

class SurahModel extends Surah {
  const SurahModel(
      {required super.number,
      required super.name,
      required super.revelationType,
      required super.numberOfAyahs});

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
        number: json["number"],
        name: json["name"],
        revelationType: json["revelationType"],
        numberOfAyahs: json["numberOfAyahs"]);
  }
}
