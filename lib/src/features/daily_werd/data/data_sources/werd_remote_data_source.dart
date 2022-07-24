import 'dart:io';

import 'package:dio/dio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app_clean_architecture/src/core/constants/keys.dart';
import 'package:quran_app_clean_architecture/src/core/constants/urls.dart';
import 'package:quran_app_clean_architecture/src/core/date/date_info.dart';
import 'package:quran_app_clean_architecture/src/core/error/exceptions.dart';
import 'package:quran_app_clean_architecture/src/core/models/ayah_model.dart';
import 'package:quran_app_clean_architecture/src/core/utils/random_int.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/werd_model.dart';

abstract class WerdRemoteDataSource {
  Future<WerdModel> getWerd({required Settings settings});
}

class WerdRemoteDataSourceImpl extends WerdRemoteDataSource {
  final Dio dio;
  final DateInfo dateInfo;
  final SharedPreferences sharedPreferences;

  WerdRemoteDataSourceImpl(
      {required this.dio,
      required this.dateInfo,
      required this.sharedPreferences});
  @override
  Future<WerdModel> getWerd({required Settings settings}) async {
    int randomRukuNum;
    final cashedRandomRukuNum = sharedPreferences.getInt(randomRukuNumKey);
    print(cashedRandomRukuNum);
    if (dateInfo.isNewADay() || cashedRandomRukuNum == null) {
      randomRukuNum = getRandomInt(558);
      sharedPreferences.setInt(randomRukuNumKey, randomRukuNum);
    } else {
      print("f");
      randomRukuNum = cashedRandomRukuNum;
    }

    try {
      final ayahs = await _getAyahs(settings: settings, rukuNum: randomRukuNum);
      print(ayahs);

      final audioPlayer = await _getPlayer(settings: settings, ayahs: ayahs);
      return WerdModel(audio: audioPlayer, ayahs: ayahs);
    } on ServerExciption {
      rethrow;
    }
  }

  Future<List<AyahModel>> _getAyahs({
    required Settings settings,
    required int rukuNum,
  }) async {
    final response = await dio.get(
        "$quranApiBaseUrl/ruku/$rukuNum/${settings.quranEdition}?limit=${settings.ayahsCount}");

    if (response.statusCode == 200) {
      final List jsonData = response.data["data"]["ayahs"];
      final List<AyahModel> ayahsList =
          jsonData.map((ayahJson) => AyahModel.fromJson(ayahJson)).toList();
      return ayahsList;
    } else {
      throw ServerExciption();
    }
  }

  Future<AudioPlayer> _getPlayer(
      {required Settings settings, required List<AyahModel> ayahs}) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final firstAyah = ayahs.first;
    final ayahsCount = ayahs.length;
    final surahNum = firstAyah.surah.number;
    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: [
        for (int i = firstAyah.numberInSurah;
            i < firstAyah.numberInSurah + ayahsCount;
            i++)
          AudioSource.uri(
            Uri.parse(
              _formatToAVaildUrl(
                ayahNum: i,
                pageNum: surahNum,
                quranRecuter: settings.quranRecuter,
              ),
            ),
          ),
      ],
    );
    final player = AudioPlayer();
    await player.setAudioSource(playlist);
    return player;
  }

  String _mapIntToStringForEveryAyahApi(int number) {
    switch (number.toString().length) {
      case 1:
        return "00$number";
      case 2:
        return "0$number";
      case 3:
        return "$number";
      default:
        return "$number";
    }
  }

  String _formatToAVaildUrl(
      {required String quranRecuter,
      required int pageNum,
      required int ayahNum}) {
    return 'https://www.everyayah.com/data/$quranRecuter/${_mapIntToStringForEveryAyahApi(pageNum)}${_mapIntToStringForEveryAyahApi(ayahNum)}.mp3';
  }
}
