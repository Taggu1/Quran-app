import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToggleThemeTile extends StatelessWidget {
  const ToggleThemeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        if (state is LoadedThemeState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppLocalizations.of(context)!.darkTheme,
                style: Theme.of(context).textTheme.headline4,
              ),
              Switch(
                  value: state.themeMode == ThemeMode.dark ? true : false,
                  onChanged: (val) => _onChanged(context, val))
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _onChanged(BuildContext context, bool val) {
    final themeMode = val == true ? ThemeMode.dark : ThemeMode.light;
    BlocProvider.of<ThemeCubit>(context).toggleTheme(themeMode: themeMode);
  }
}
