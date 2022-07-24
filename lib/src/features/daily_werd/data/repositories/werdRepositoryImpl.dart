import 'package:quran_app_clean_architecture/src/core/date/date_info.dart';
import 'package:quran_app_clean_architecture/src/core/error/exceptions.dart';
import 'package:quran_app_clean_architecture/src/core/network/network_info.dart';
import 'package:quran_app_clean_architecture/src/core/settings/settings_info.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/data/data_sources/werd_local_data_source.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/data/data_sources/werd_remote_data_source.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/domain/entities/werd.dart';
import 'package:quran_app_clean_architecture/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/domain/repositories/werd_repository.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';

import '../models/werd_model.dart';

class WerdRepositoryImpl implements WerdRepository {
  final WerdLocalDataSource werdLocalDataSource;
  final WerdRemoteDataSource werdRemoteDataSource;
  final NetWorkInfo netWorkInfo;
  final SettingsInfo settingsInfo;

  WerdRepositoryImpl({
    required this.settingsInfo,
    required this.werdRemoteDataSource,
    required this.werdLocalDataSource,
    required this.netWorkInfo,
  });
  @override
  Future<Either<Failure, Werd>> fetchWerd() async {
    if (await netWorkInfo.isConnected()) {
      try {
        print("connected");
        final WerdModel werd = await werdRemoteDataSource.getWerd(
            settings: settingsInfo.settings!);
        werdLocalDataSource.casheWerd(ayahs: werd.ayahs);
        return Right(werd);
      } on ServerExciption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final WerdModel werd = await werdLocalDataSource.getCashedWerd();
        return Right(werd);
      } on EmptyCasheException {
        return Left(EmptyCasheFailure());
      }
    }
  }
}
