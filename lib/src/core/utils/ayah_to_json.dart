import 'package:quran_app_clean_architecture/src/core/entities/ayah.dart';

extension AyahExtintion on Ayah {
  Map<String, dynamic> toJson() {
    return {
      "number": number,
      "text": text,
      "numberInSurah": numberInSurah,
      "juz": juz,
      "manzil": manzil,
      "page": page,
      "ruku": ruku,
      "hizbQuarter": hizbQuarter,
      "surah": {
        "number": surah.number,
        "name": surah.name,
        "revelationType": surah.revelationType,
        "numberOfAyahs": surah.numberOfAyahs,
      }
    };
  }
}
