import 'package:flutter/material.dart';
import 'package:quran_app_clean_architecture/src/core/constants/keys.dart';
import 'package:quran_app_clean_architecture/src/core/constants/strings.dart';

import 'package:quran_app_clean_architecture/src/features/settings/presentation/widgets/options_list_pop_up_card.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/widgets/toggle_theme_tile.dart';

import '../../../../core/constants/options_tiles_data.dart';
import '../../../../core/settings/settings_info.dart';
import '../widgets/OptionsTile.dart';
import '../../../../../injection_container.dart' as di;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ToggleThemeTile(),
          EditionsOptionsTileBuilder(settingsInfo: settingsInfo),
          QarisOptionsTileBuilder(settingsInfo: settingsInfo),
          AyahsOptionsTileBuilder(settingsInfo: settingsInfo),
          LanguagesOptionsTileBuilder(settingsInfo: settingsInfo),
        ],
      ),
    );
  }
}

class LanguagesOptionsTileBuilder extends StatelessWidget {
  const LanguagesOptionsTileBuilder({
    Key? key,
    required this.settingsInfo,
  }) : super(key: key);

  final SettingsInfo settingsInfo;

  @override
  Widget build(BuildContext context) {
    return OptionsTile(
      popUpPage: OptionsListPopUpCard(
        isLang: true,
        title: AppLocalizations.of(context)!.language,
        settingkey: appLanguageKey,
        settingsInfo: settingsInfo,
        initalValue: settingsInfo.settings?.appLanguage,
        listValues: const [
          {
            "name": "العربية",
            "apiName": "ar",
          },
          {"name": "English", "apiName": "en"}
        ],
      ),
      subTitle: settingsInfo.settings!.appLanguage,
      tag: "lang-tag",
      title: AppLocalizations.of(context)!.language,
    );
  }
}

class EditionsOptionsTileBuilder extends StatelessWidget {
  const EditionsOptionsTileBuilder({
    Key? key,
    required this.settingsInfo,
  }) : super(key: key);

  final SettingsInfo settingsInfo;

  @override
  Widget build(BuildContext context) {
    return OptionsTile(
      popUpPage: OptionsListPopUpCard(
        title: AppLocalizations.of(context)!.editions,
        settingkey: quranEditionKey,
        settingsInfo: settingsInfo,
        initalValue: settingsInfo.settings?.quranEdition,
        listValues: editionsList,
      ),
      subTitle: settingsInfo.settings!.quranEdition,
      tag: editionsSettingsTileTag,
      title: AppLocalizations.of(context)!.editions,
    );
  }
}

class QarisOptionsTileBuilder extends StatelessWidget {
  const QarisOptionsTileBuilder({
    Key? key,
    required this.settingsInfo,
  }) : super(key: key);

  final SettingsInfo settingsInfo;

  @override
  Widget build(BuildContext context) {
    return OptionsTile(
      popUpPage: OptionsListPopUpCard(
        settingkey: quranRecuterKey,
        settingsInfo: settingsInfo,
        title: AppLocalizations.of(context)!.recutiers,
        initalValue: settingsInfo.settings?.quranRecuter,
        listValues: recrutersList,
      ),
      subTitle: settingsInfo.settings!.quranRecuter,
      tag: qarisSettingsTileTag,
      title: AppLocalizations.of(context)!.recutiers,
    );
  }
}

class AyahsOptionsTileBuilder extends StatelessWidget {
  const AyahsOptionsTileBuilder({
    Key? key,
    required this.settingsInfo,
  }) : super(key: key);

  final SettingsInfo settingsInfo;

  @override
  Widget build(BuildContext context) {
    return OptionsTile(
      popUpPage: OptionsListPopUpCard(
        settingkey: ayahsCountKey,
        settingsInfo: settingsInfo,
        title: AppLocalizations.of(context)!.versesCount,
        initalValue: settingsInfo.settings?.ayahsCount.toString(),
        listValues: ayahsCountList,
      ),
      subTitle: settingsInfo.settings!.ayahsCount.toString(),
      tag: ayahsCountSettingsTileTag,
      title: AppLocalizations.of(context)!.versesCount,
    );
  }
}
