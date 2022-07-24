import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app_clean_architecture/src/core/settings/settings_info.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/keys.dart';
import '../../../daily_werd/presentation/bloc/werd/werd_bloc.dart';
import '../../domain/entities/edition.dart';
import '../../domain/entities/recruter.dart';

class EditionOptionsTile extends StatefulWidget {
  final SettingsInfo settingsInfo;
  const EditionOptionsTile({Key? key, required this.settingsInfo})
      : super(key: key);

  @override
  State<EditionOptionsTile> createState() => _EditionOptionsTileState();
}

class _EditionOptionsTileState extends State<EditionOptionsTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Choose Edition",
          style: Theme.of(context).textTheme.headline4,
        ),
        DropdownButton(
            dropdownColor: kBlackColor,
            style: Theme.of(context).textTheme.headline4,
            items: editionsList
                .map(
                  (recruter) => DropdownMenuItem(
                    child: Text(recruter.name),
                    value: recruter.apiName,
                  ),
                )
                .toList(),
            onChanged: _onButtonChanged),
      ],
    );
  }

  void _onButtonChanged(String? val) {
    setState(() {});

    widget.settingsInfo.updateOneSettingWithKey(quranEditionKey, val);
    BlocProvider.of<WerdBloc>(context).add(FetchWerdEvent());
  }
}
