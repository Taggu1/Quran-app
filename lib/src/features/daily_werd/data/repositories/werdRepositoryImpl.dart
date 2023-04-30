import 'package:dartz/dartz.dart';
import 'package:quran_app_clean_architecture/src/features/settings/data/data_sources/settings_local_data_source.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/settings/settings_info.dart';
import '../../domain/entities/werd.dart';
import '../../domain/repositories/werd_repository.dart';
import '../data_sources/werd_local_data_source.dart';
import '../data_sources/werd_remote_data_source.dart';
import '../models/werd_model.dart';

class WerdRepositoryImpl implements WerdRepository {
  final WerdLocalDataSource werdLocalDataSource;
  final WerdRemoteDataSource werdRemoteDataSource;
  final NetWorkInfo netWorkInfo;
  final SettingsLocalDataSource settingsLocalDataSource;

  WerdRepositoryImpl({
    required this.settingsLocalDataSource,
    required this.werdRemoteDataSource,
    required this.werdLocalDataSource,
    required this.netWorkInfo,
  });
  @override
  Future<Either<Failure, Werd>> fetchWerd() async {
    bool isConnected = await netWorkInfo.isConnected();
    final settings = await settingsLocalDataSource.fetchSettings();
    if (isConnected) {
      try {
        print("connected");
        final WerdModel werd =
            await werdRemoteDataSource.getWerd(settings: settings);
        werdLocalDataSource.casheWerd(ayahs: werd.ayahs);
        return Right(werd);
      } on ServerExciption {
        print("WOHLYSHIT");
        return Left(ServerFailure());
      }
    } else {
      try {
        final WerdModel werd =
            await werdLocalDataSource.getCashedWerd(settings: settings);
        return Right(werd);
      } on EmptyCasheException {
        return Left(EmptyCasheFailure());
      }
    }
  }
}
