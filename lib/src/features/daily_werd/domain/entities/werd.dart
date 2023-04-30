import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/entities/ayah.dart';

class Werd extends Equatable {
  final List<Ayah> ayahs;
  final AudioPlayer? audio;
  final bool isAudioPlaying;
  final int currentAyahPlaying;
  final int page;
  final String surah;
  final int hizab;
  final int juz;

  const Werd({
    required this.currentAyahPlaying,
    required this.isAudioPlaying,
    required this.juz,
    required this.audio,
    required this.ayahs,
    required this.page,
    required this.surah,
    required this.hizab,
  });
  @override
  List<Object?> get props =>
      [audio, ayahs, page, hizab, surah, isAudioPlaying, currentAyahPlaying];

  Werd copyWith(
      {AudioPlayer? audio, bool? isAudioPlaying, int? currentAyahPlaying}) {
    return Werd(
      juz: juz,
      audio: audio ?? this.audio,
      ayahs: ayahs,
      page: page,
      surah: surah,
      hizab: hizab,
      isAudioPlaying: isAudioPlaying ?? this.isAudioPlaying,
      currentAyahPlaying: currentAyahPlaying ?? this.currentAyahPlaying,
    );
  }
}
