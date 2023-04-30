import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';

import '../../../../core/constants/keys.dart';
import '../../../../core/constants/options_tiles_data.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/settings/settings_info.dart';
import '../bloc/cubit/settings_cubit.dart';
import '../widgets/OptionsTile.dart';
import '../../../../../injection_container.dart' as di;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/options_list_pop_up_card.dart';
import '../widgets/toggle_theme_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final settingsInfo = di.sl<SettingsInfo>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        child: SettingsTilesColumn(settingsInfo: settingsInfo),
      ),
    );
  }
}

class SettingsTilesColumn extends StatelessWidget {
  const SettingsTilesColumn({
    Key? key,
    required this.settingsInfo,
  }) : super(key: key);

  final SettingsInfo settingsInfo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const ToggleThemeTile(),
              EditionsOptionsTileBuilder(
                settings: state.settings,
              ),
              QarisOptionsTileBuilder(
                settings: state.settings,
              ),
              AyahsOptionsTileBuilder(
                settings: state.settings,
              ),
              LanguagesOptionsTileBuilder(
                settings: state.settings,
              ),
            ],
          );
        },
      ),
    );
  }
}

class LanguagesOptionsTileBuilder extends StatelessWidget {
  const LanguagesOptionsTileBuilder({
    Key? key,
    required this.settings,
  }) : super(key: key);
  final UserSettings settings;

  @override
  Widget build(BuildContext context) {
    return OptionsTile(
      popUpPage: OptionsListPopUpCard(
        isLang: true,
        title: AppLocalizations.of(context)!.language,
        settingkey: appLanguageKey,
        initalValue: settings.appLanguage,
        listValues: const [
          {
            "name": "العربية",
            "apiName": "ar",
          },
          {"name": "English", "apiName": "en"}
        ],
      ),
      subTitle: settings.appLanguage,
      tag: "lang-tag",
      title: AppLocalizations.of(context)!.language,
    );
  }
}

class EditionsOptionsTileBuilder extends StatelessWidget {
  final UserSettings settings;
  const EditionsOptionsTileBuilder({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionsTile(
      popUpPage: OptionsListPopUpCard(
        title: AppLocalizations.of(context)!.editions,
        settingkey: quranEditionKey,
        initalValue: settings.quranEdition,
        listValues: editionsList,
      ),
      subTitle: settings.quranEdition,
      tag: editionsSettingsTileTag,
      title: AppLocalizations.of(context)!.editions,
    );
  }
}

class QarisOptionsTileBuilder extends StatelessWidget {
  final UserSettings settings;
  const QarisOptionsTileBuilder({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionsTile(
      popUpPage: OptionsListPopUpCard(
        settingkey: quranRecuterKey,
        title: AppLocalizations.of(context)!.recutiers,
        initalValue: settings.quranRecuter,
        listValues: recrutersList,
      ),
      subTitle: settings.quranRecuter,
      tag: qarisSettingsTileTag,
      title: AppLocalizations.of(context)!.recutiers,
    );
  }
}

class AyahsOptionsTileBuilder extends StatelessWidget {
  final UserSettings settings;
  const AyahsOptionsTileBuilder({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionsTile(
      popUpPage: OptionsListPopUpCard(
        settingkey: ayahsCountKey,
        title: AppLocalizations.of(context)!.versesCount,
        initalValue: settings.ayahsCount.toString(),
        listValues: ayahsCountList,
      ),
      subTitle: settings.ayahsCount.toString(),
      tag: ayahsCountSettingsTileTag,
      title: AppLocalizations.of(context)!.versesCount,
    );
  }
}
