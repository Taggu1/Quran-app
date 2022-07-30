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
import 'package:quran_app_clean_architecture/src/features/locale/presentation/cubit/locale_cubit.dart';
import 'package:quran_app_clean_architecture/src/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:quran_app_clean_architecture/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/use_cases/fetch_settings_use_case.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/use_cases/update_settings_use_case.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/cubit/settings_cubit.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/settings_bloc/settings_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/theme/data/data_sources/theme_local_data_source.dart';
import 'package:quran_app_clean_architecture/src/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:quran_app_clean_architecture/src/features/theme/domain/repositories/themeRepository.dart';
import 'package:quran_app_clean_architecture/src/features/theme/domain/use_cases/fetch_theme_mode_use_case.dart';
import 'package:quran_app_clean_architecture/src/features/theme/domain/use_cases/toggle_theme_use_case.dart';
import 'package:quran_app_clean_architecture/src/features/theme/presentation/cubit/theme_cubit.dart';
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

  sl.registerFactory(
    () => LocaleCubit(settingsInfo: sl())..fetchLocal(),
  );

  sl.registerFactory(
      () => ThemeCubit(fetchThemeModeUseCase: sl(), toggleThemeUseCase: sl()));

  // UseCases

  sl.registerLazySingleton(
    () => FetchThemeModeUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => ToggleThemeUseCase(themeRepository: sl()),
  );

  sl.registerLazySingleton<FetchSettingsUseCase>(
    () => FetchSettingsUseCase(repository: sl()),
  );

  sl.registerLazySingleton<UpdateSettingWithKeyUseCase>(
    () => UpdateSettingWithKeyUseCase(repository: sl()),
  );

  sl.registerLazySingleton<FetchWerdUseCase>(
    () => FetchWerdUseCase(repository: sl()),
  );

  // Repositories

  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(themeLocalDataSource: sl()),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(settingsLocalDataSource: sl()),
  );

  sl.registerLazySingleton<WerdRepository>(
    () => WerdRepositoryImpl(
      settingsInfo: sl(),
      werdLocalDataSource: sl(),
      werdRemoteDataSource: sl(),
      netWorkInfo: sl(),
    ),
  );

  // Data Sources

  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
  );

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

  sl.registerLazySingleton<NetWorkInfo>(
    () => NetWorkInfoInternetConnectionCheckerImpl(
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
