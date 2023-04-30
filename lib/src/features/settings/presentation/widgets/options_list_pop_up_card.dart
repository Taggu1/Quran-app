import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/cubit/settings_cubit.dart';

import '../../../../core/settings/settings_info.dart';
import '../../../daily_werd/presentation/bloc/werd/werd_bloc.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';

class OptionsListPopUpCard extends StatefulWidget {
  final String title;
  final String settingkey;
  final String? initalValue;
  final bool? isLang;
  final List<Map<String, String>> listValues;

  const OptionsListPopUpCard(
      {Key? key,
      required this.title,
      required this.settingkey,
      required this.initalValue,
      required this.listValues,
      this.isLang})
      : super(key: key);

  @override
  State<OptionsListPopUpCard> createState() => _OptionsListPopUpCardState();
}

class _OptionsListPopUpCardState extends State<OptionsListPopUpCard> {
  var _groupValue = "";

  @override
  void initState() {
    _groupValue = widget.initalValue!;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).backgroundColor,
      width: size.width * 0.8,
      height: size.height * 0.6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 20,
            ),
            ...widget.listValues
                .map<RadioListTile>(
                  (qari) => RadioListTile(
                      title: Text(
                        qari["name"]!,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      value: qari["apiName"],
                      groupValue: _groupValue,
                      onChanged: _onButtonChanged),
                )
                .toList()
          ],
        ),
      ),
    );
  }

  void _onButtonChanged(dynamic val) {
    setState(() {
      _groupValue = val;
    });

    context
        .read<SettingsCubit>()
        .updateOneSettingWithKey(key: widget.settingkey, value: val);

    context.read<WerdBloc>().add(TogglePlayerPlayingStateEvent(play: false));

    if (widget.isLang == true) {
      BlocProvider.of<LocaleCubit>(context).setLocal(Locale(val));
    } else {
      BlocProvider.of<WerdBloc>(context).add(FetchWerdEvent());
    }
  }
}
