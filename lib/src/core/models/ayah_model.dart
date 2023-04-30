import '../entities/ayah.dart';
import 'surah_model.dart';

class AyahModel extends Ayah {
  const AyahModel({
    required super.numberInSurah,
    required super.number,
    required super.juz,
    required super.manzil,
    required super.page,
    required super.ruku,
    required super.hizbQuarter,
    required super.text,
    required super.surah,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      numberInSurah: json["numberInSurah"],
      number: json["number"],
      juz: json["juz"],
      manzil: json["manzil"],
      page: json["page"],
      ruku: json["ruku"],
      hizbQuarter: json["hizbQuarter"],
      text: json["text"],
      surah: SurahModel.fromJson(
        json["surah"],
      ),
    );
  }
}
