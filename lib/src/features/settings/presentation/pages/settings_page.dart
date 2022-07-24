import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/bloc/werd/werd_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/recruter.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/settings/settings_info.dart';
import '../widgets/EditionOptionsTile.dart';
import '../widgets/qariOptionsTile.dart';
import '../../../../../injection_container.dart' as di;

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
        padding: const EdgeInsets.all(10),
        color: kBlackColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QariOptionsTile(
              settingsInfo: settingsInfo,
            ),
            FittedBox(
              child: EditionOptionsTile(
                settingsInfo: settingsInfo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
