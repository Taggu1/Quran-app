import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/cubit/settings_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/date/date_info.dart';
import 'src/core/network/network_info.dart';
import 'src/core/settings/settings_info.dart';
import 'src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'src/features/auth/data/repositories/auth_repo_impl.dart';
import 'src/features/auth/domain/repositories/auth_repo.dart';
import 'src/features/auth/domain/use_cases/fetch_user_data_from_storage_use_case.dart';
import 'src/features/auth/domain/use_cases/log_in_user_with_third_party_use_case.dart';
import 'src/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'src/features/auth/domain/use_cases/sign_up_or_login_as_a_guest_use_case.dart';
import 'src/features/auth/domain/use_cases/sign_up_or_login_with_email_and_password_use_case.dart';
import 'src/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'src/features/daily_werd/data/data_sources/werd_local_data_source.dart';
import 'src/features/daily_werd/data/data_sources/werd_remote_data_source.dart';
import 'src/features/daily_werd/data/repositories/werdRepositoryImpl.dart';
import 'src/features/daily_werd/domain/repositories/werd_repository.dart';
import 'src/features/daily_werd/domain/use_cases/fetch_werd_use_case.dart';
import 'src/features/daily_werd/presentation/bloc/werd/werd_bloc.dart';
import 'src/features/locale/presentation/cubit/locale_cubit.dart';
import 'src/features/progress/data/data_sources/user_progress_remote_data_source.dart';
import 'src/features/progress/data/repositories/user_progress_repository_impl.dart';
import 'src/features/progress/domain/repositories/user_progress_repository.dart';
import 'src/features/progress/domain/use_cases/fetch_user_progress_data_use_case.dart';
import 'src/features/progress/domain/use_cases/update_user_progress_data_use_case.dart';
import 'src/features/progress/presentation/bloc/bloc/user_progress_bloc.dart';
import 'src/features/settings/data/data_sources/settings_local_data_source.dart';
import 'src/features/settings/data/repositories/settings_repository_impl.dart';
import 'src/features/settings/domain/repositories/settings_repository.dart';
import 'src/features/settings/domain/use_cases/fetch_settings_use_case.dart';
import 'src/features/settings/domain/use_cases/update_settings_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - settings - werd

  // Bloc

  _registerBlocs();

  // UseCases
  _registerUseCases();
  // Repositories
  _registerRepositories();

  // Data Sources
  _registerDataSources();

  /// Core

  _registerCore();

  /// External
  await _registerExternals();
}

void _registerBlocs() {
  sl.registerFactory(() => UserProgressBloc(
      fetchUserProgressDataUseCase: sl(), updateUserProgressDataUseCase: sl()));

  sl.registerFactory(
    () => WerdBloc(
      fetchWerdUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => AuthBloc(
      signUpOrLoginWithEmailAndPasswordUseCase: sl(),
      fetchUserDataFromSotrageUseCase: sl(),
      signOutUseCase: sl(),
      signUpOrLoginAsAGuestUseCase: sl(),
      logInUserWithThirdPartyUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => SettingsCubit(
      fetchSettingsUseCase: sl(),
      updateSettingWithKeyUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => LocaleCubit(settingsInfo: sl())..fetchLocal(),
  );
}

void _registerUseCases() {
  sl.registerLazySingleton(
    () => FetchUserProgressDataUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => UpdateUserProgressDataUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => SignUpOrLoginAsAGuestUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SignUpOrLoginWithEmailAndPasswordUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => LogInUserWithThirdPartyUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => FetchUserDataFromSotrageUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SignOutUseCase(
      repository: sl(),
    ),
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
}

void _registerRepositories() {
  sl.registerLazySingleton<UserProgressRepository>(
    () => UserProgressRepositoryImpl(
      userProgressRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      authLocalDataSource: sl(),
      authRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(settingsLocalDataSource: sl()),
  );

  sl.registerLazySingleton<WerdRepository>(
    () => WerdRepositoryImpl(
      settingsLocalDataSource: sl(),
      werdLocalDataSource: sl(),
      werdRemoteDataSource: sl(),
      netWorkInfo: sl(),
    ),
  );
}

void _registerDataSources() {
  sl.registerLazySingleton<UserProgressRemoteDataSource>(
    () => UserProgressRemoteDataSourceImpl(db: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
    ),
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
}

void _registerCore() {
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
}

Future<void> _registerExternals() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerLazySingleton(() => GoogleSignIn());
}
