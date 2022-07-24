import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app_clean_architecture/src/core/entities/ayah.dart';

class Werd extends Equatable {
  final List<Ayah> ayahs;
  final AudioPlayer audio;

  const Werd({
    required this.audio,
    required this.ayahs,
  });
  @override
  List<Object?> get props => [audio, ayahs];
}
