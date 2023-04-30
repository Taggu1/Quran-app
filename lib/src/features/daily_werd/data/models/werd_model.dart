import '../../domain/entities/werd.dart';

class WerdModel extends Werd {
  const WerdModel(
      {required super.audio,
      required super.ayahs,
      required super.hizab,
      required super.page,
      required super.surah,
      required super.juz,
      super.isAudioPlaying = false,
      super.currentAyahPlaying = 0});
}
