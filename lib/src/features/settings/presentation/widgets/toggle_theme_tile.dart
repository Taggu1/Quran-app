import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/cubit/settings_cubit.dart';

class ToggleThemeTile extends StatelessWidget {
  const ToggleThemeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final settings = state.settings;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              AppLocalizations.of(context)!.darkTheme,
              style: Theme.of(context).textTheme.headline4,
            ),
            IconButton(
                onPressed: () => _onChanged(context, settings.isDarkTheme),
                icon: Icon(
                  settings.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).iconTheme.color,
                ))
          ],
        );
      },
    );
  }

  void _onChanged(BuildContext context, bool isDark) {}
}
