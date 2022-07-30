import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:quran_app_clean_architecture/src/core/constants/colors.dart';
import 'package:quran_app_clean_architecture/src/core/settings/settings_info.dart';
import 'package:quran_app_clean_architecture/src/core/constants/theme_constants.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/bloc/werd/werd_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/pages/bottom_navbar.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/pages/main_page.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/cubit/settings_cubit.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/settings_bloc/settings_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'injection_container.dart' as di;
import 'l10n/l10n.dart';
import 'src/features/locale/presentation/cubit/locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  debugRepaintRainbowEnabled = true;
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
            return di.sl<LocaleCubit>();
          },
        ),
        BlocProvider(
          create: (ctx) {
            return di.sl<ThemeCubit>()..fetchThemeMode();
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
          return BlocBuilder<ThemeCubit, ThemeState>(
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

  ThemeMode _themModeHandler(BuildContext context, state) {
    if (state is LoadedThemeState) {
      return state.themeMode;
    } else {
      return ThemeMode.dark;
    }
  }
}
