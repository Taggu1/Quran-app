import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app_clean_architecture/src/core/entities/ayah.dart';
import 'package:quran_app_clean_architecture/src/core/error/exceptions.dart';
import 'package:quran_app_clean_architecture/src/core/models/ayah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/keys.dart';
import '../../domain/entities/werd.dart';
import '../models/werd_model.dart';
import '../../../../core/utils/ayah_to_json.dart';

abstract class WerdLocalDataSource {
  Future<Unit> casheWerd({required List<Ayah> ayahs});
  Future<WerdModel> getCashedWerd();
}

class WerdLocalDataSourceImpl extends WerdLocalDataSource {
  final SharedPreferences sharedPreferences;

  WerdLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> casheWerd({required List<Ayah> ayahs}) {
    try {
      final List ayahsMapList = ayahs.map((ayah) => ayah.toJson()).toList();
      final ayahsjsonString = jsonEncode(ayahsMapList);
      sharedPreferences.setString(cashedAyahsKey, ayahsjsonString);
      return Future.value(unit);
    } catch (e) {
      throw EmptyCasheException();
    }
  }

  @override
  Future<WerdModel> getCashedWerd() async {
    try {
      final ayahs = _getAyahsFromLocal();

      final audio = await _getPlayerFromLocal(ayahs: ayahs);

      return WerdModel(audio: audio, ayahs: ayahs);
    } catch (e) {
      throw EmptyCasheException();
    }
  }

  List<AyahModel> _getAyahsFromLocal() {
    final cashedAyahsString = sharedPreferences.getString(cashedAyahsKey)!;
    final List ayahsMapList = jsonDecode(cashedAyahsString);
    final List<AyahModel> ayahsList =
        ayahsMapList.map((ayahJson) => AyahModel.fromJson(ayahJson)).toList();
    return ayahsList;
  }

  Future<AudioPlayer> _getPlayerFromLocal(
      {required List<AyahModel> ayahs}) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final firstAyah = ayahs.first;
    final ayahsCount = ayahs.length;
    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: [
        for (int i = firstAyah.numberInSurah;
            i < firstAyah.numberInSurah + ayahsCount;
            i++)
          AudioSource.uri(Uri.parse("${appStorage.path}/$i"))
      ],
    );
    final player = AudioPlayer();
    await player.setAudioSource(playlist);
    return player;
  }
}
