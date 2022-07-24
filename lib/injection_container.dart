import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quran_app_clean_architecture/src/core/date/date_info.dart';
import 'package:quran_app_clean_architecture/src/core/network/network_info.dart';
import 'package:quran_app_clean_architecture/src/core/settings/settings_info.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/data/data_sources/werd_local_data_source.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/data/data_sources/werd_remote_data_source.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/data/repositories/werdRepositoryImpl.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/domain/repositories/werd_repository.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/domain/use_cases/fetch_werd_use_case.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/bloc/werd/werd_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:quran_app_clean_architecture/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/use_cases/fetch_settings_use_case.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/use_cases/update_settings_use_case.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/settings_bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - settings - werd

  // Bloc

  sl.registerFactory(
    () => WerdBloc(
      fetchWerdUseCase: sl(),
    ),
  );

  // UseCases

  sl.registerLazySingleton<FetchWerdUseCase>(
    () => FetchWerdUseCase(repository: sl()),
  );

  // Repositories

  sl.registerLazySingleton<WerdRepository>(
    () => WerdRepositoryImpl(
      werdLocalDataSource: sl(),
      werdRemoteDataSource: sl(),
      netWorkInfo: sl(),
      settingsInfo: sl(),
    ),
  );

  // Data Sources

  sl.registerLazySingleton<WerdLocalDataSource>(
    () => WerdLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<WerdRemoteDataSource>(
    () => WerdRemoteDataSourceImpl(
        dio: sl(), dateInfo: sl(), sharedPreferences: sl()),
  );

  /// Core

  sl.registerLazySingleton(
    () => NetWorkInfo(
      internetConnectionChecker: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DateInfo(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SettingsInfo(
      sharedPreferences: sl(),
    )..fetchSettings(),
  );

  /// External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
