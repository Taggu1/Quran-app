import 'package:quran_app_clean_architecture/src/features/daily_werd/domain/entities/werd.dart';

class WerdModel extends Werd {
  const WerdModel(
      {required super.audio,
      required super.ayahs,
      required super.hizab,
      required super.page,
      required super.surah,
      required super.juz});
}
