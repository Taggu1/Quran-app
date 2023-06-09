import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/ints.dart';
import '../../../../core/constants/keys.dart';
import '../../../../core/constants/urls.dart';
import '../../../../core/date/date_info.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/models/ayah_model.dart';
import '../../../../core/utils/audio_url_helper_functions.dart';
import '../../../../core/utils/random_int.dart';
import '../../../settings/domain/entities/settings.dart';
import '../models/werd_model.dart';

abstract class WerdRemoteDataSource {
  Future<WerdModel> getWerd({required UserSettings settings});
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
  Future<WerdModel> getWerd({required UserSettings settings}) async {
    try {
      final randomRukuNum = _getRandomRukuNum();
      final ayahs = await _getAyahs(settings: settings, rukuNum: randomRukuNum);

      final audioPlayer =
          await getPlayer(settings: settings, ayahs: ayahs, fromInternet: true);
      final firstAyah = ayahs.first;

      return WerdModel(
          audio: audioPlayer,
          ayahs: ayahs,
          hizab: firstAyah.hizbQuarter,
          page: firstAyah.page,
          surah: firstAyah.surah.name,
          juz: firstAyah.juz);
    } on ServerExciption {
      rethrow;
    } catch (e) {
      throw ServerExciption();
    }
  }

  Future<List<AyahModel>> _getAyahs({
    required UserSettings settings,
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

  int _getRandomRukuNum() {
    int randomRukuNum;
    final cashedRandomRukuNum = sharedPreferences.getInt(randomRukuNumKey);

    if (dateInfo.isNewADay() || cashedRandomRukuNum == null) {
      randomRukuNum = getRandomInt(quranRukusNum);
      sharedPreferences.setInt(randomRukuNumKey, randomRukuNum);
    } else {
      randomRukuNum = cashedRandomRukuNum;
    }
    return randomRukuNum;
  }
}
