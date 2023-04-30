import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/cubit/settings_cubit.dart';

import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'l10n/l10n.dart';
import 'src/core/constants/theme_constants.dart';
import 'src/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'src/features/daily_werd/presentation/bloc/werd/werd_bloc.dart';
import 'src/features/daily_werd/presentation/pages/bottom_navbar.dart';
import 'src/features/locale/presentation/cubit/locale_cubit.dart';
import 'src/features/progress/presentation/bloc/bloc/user_progress_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            return di.sl<UserProgressBloc>();
          },
        ),
        BlocProvider(
          create: (ctx) {
            return di.sl<AuthBloc>()..add(FetchUserFromStorageEvent());
          },
          lazy: false,
        ),
        BlocProvider(
          create: (ctx) {
            return di.sl<LocaleCubit>();
          },
        ),
        BlocProvider(
          create: (ctx) {
            return di.sl<SettingsCubit>()..fetchSettings();
          },
        ),
        BlocProvider(
          create: (ctx) {
            return di.sl<WerdBloc>()..add(FetchWerdEvent());
          },
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: lightTheme,
                darkTheme: darkTheme,
                supportedLocales: L10n.all,
                locale: localeState.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                themeMode: _themModeHandler(context, state),
                home: const BottomNavBar(),
              );
            },
          );
        },
      ),
    );
  }

  ThemeMode _themModeHandler(BuildContext context, SettingsState state) {
    return state.settings.isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }
}
