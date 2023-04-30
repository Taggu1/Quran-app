import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/settings/domain/entities/settings.dart';
import '../models/ayah_model.dart';

Future<AudioPlayer?> getPlayer(
    {required List<AyahModel> ayahs,
    required UserSettings settings,
    required bool fromInternet}) async {
  final appStorage = await getApplicationDocumentsDirectory();
  final firstAyah = ayahs.first;
  final ayahsCount = ayahs.length;
  final surahNum = firstAyah.surah.number;
  try {
    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: [
        for (int i = firstAyah.numberInSurah;
            i < firstAyah.numberInSurah + ayahsCount;
            i++)
          LockCachingAudioSource(
            Uri.parse(
              formatToAVaildUrl(
                  quranRecuter: settings.quranRecuter,
                  ayahNum: i,
                  surahNum: surahNum,
                  storagePath: appStorage.path,
                  fromInternet: fromInternet),
            ),
          )
      ],
    );
    final player = AudioPlayer();

    await player.setAudioSource(playlist);
    return player;
  } catch (e) {
    print("LOOOOOOl");
  }
  return AudioPlayer();
}

String formatToAVaildUrl({
  required String quranRecuter,
  required int ayahNum,
  required int surahNum,
  required String storagePath,
  required bool fromInternet,
}) {
  if (fromInternet) {
    return 'https://www.everyayah.com/data/$quranRecuter/${_mapIntToStringForEveryAyahApi(surahNum)}${_mapIntToStringForEveryAyahApi(ayahNum)}.mp3';
  } else {
    return "$storagePath/audio/$quranRecuter/$ayahNum$surahNum.mp3";
  }
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
