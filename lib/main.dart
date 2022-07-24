import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app_clean_architecture/src/core/constants/colors.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/bloc/werd/werd_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/pages/bottom_navbar.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/pages/main_page.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/settings_bloc/settings_bloc.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) {
          return di.sl<WerdBloc>()..add(FetchWerdEvent());
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            backgroundColor: kBlackColor,
            primaryColor: Colors.amber,
            textTheme: ThemeData.light().textTheme.copyWith(
                headline3: const TextStyle(
                    wordSpacing: 2,
                    fontSize: 30,
                    fontFamily: "PdmsSaleemQuranFont"),
                headline4: const TextStyle(
                    wordSpacing: 2, fontSize: 17, color: Colors.white))),
        home: const BottomNavBar(),
      ),
    );
  }
}
