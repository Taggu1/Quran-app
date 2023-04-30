import 'package:equatable/equatable.dart';

import 'surah.dart';

class Ayah extends Equatable {
  final int numberInSurah;
  final int number;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final String text;
  final Surah surah;

  const Ayah({
    required this.surah,
    required this.numberInSurah,
    required this.number,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.text,
  });

  @override
  List<Object?> get props =>
      [number, numberInSurah, juz, manzil, page, ruku, hizbQuarter, text];
}
