import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app_clean_architecture/src/core/entities/ayah.dart';
import 'package:quran_app_clean_architecture/src/core/error/exceptions.dart';
import 'package:quran_app_clean_architecture/src/core/error/failures.dart';
import 'package:quran_app_clean_architecture/src/core/models/ayah_model.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/keys.dart';
import '../../../../core/utils/audio_url_helper_functions.dart';
import '../models/werd_model.dart';
import '../../../../core/utils/ayah_to_json.dart';

abstract class WerdLocalDataSource {
  Future<Unit> casheWerd({required List<Ayah> ayahs});
  Future<WerdModel> getCashedWerd({required Settings settings});
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
      throw UnknownFailure();
    }
  }

  @override
  Future<WerdModel> getCashedWerd({required Settings settings}) async {
    try {
      final ayahs = _getAyahsFromLocal();

      final audio = await getPlayer(
          ayahs: ayahs, settings: settings, fromInternet: false);

      final firstAyah = ayahs.first;

      return WerdModel(
          audio: audio,
          ayahs: ayahs,
          hizab: firstAyah.hizbQuarter,
          page: firstAyah.page,
          surah: firstAyah.surah.name,
          juz: firstAyah.juz);
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
}
