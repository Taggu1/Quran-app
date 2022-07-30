import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app_clean_architecture/src/core/entities/ayah.dart';

class Werd extends Equatable {
  final List<Ayah> ayahs;
  final AudioPlayer audio;
  final int page;
  final String surah;
  final int hizab;
  final int juz;

  const Werd({
    required this.juz,
    required this.audio,
    required this.ayahs,
    required this.page,
    required this.surah,
    required this.hizab,
  });
  @override
  List<Object?> get props => [audio, ayahs, page, hizab, surah];
}
