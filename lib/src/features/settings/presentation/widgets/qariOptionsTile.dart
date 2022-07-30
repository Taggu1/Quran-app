// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quran_app_clean_architecture/src/core/constants/colors.dart';
// import 'package:quran_app_clean_architecture/src/core/constants/keys.dart';
// import 'package:quran_app_clean_architecture/src/core/constants/qaris_list.dart';
// import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/bloc/werd/werd_bloc.dart';
// import 'package:quran_app_clean_architecture/src/features/settings/domain/entities/settings.dart';

// import '../../../../../injection_container.dart' as di;
// import '../../../../core/settings/settings_info.dart';
// import '../../domain/entities/recruter.dart';

// class QariOptionsTile extends StatefulWidget {
//   final SettingsInfo settingsInfo;
//   const QariOptionsTile({Key? key, required this.settingsInfo})
//       : super(key: key);

//   @override
//   State<QariOptionsTile> createState() => _QariOptionsTileState();
// }

// class _QariOptionsTileState extends State<QariOptionsTile> {
//   String? value;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "Choose Qari",
//           style: Theme.of(context).textTheme.headline4,
//         ),
//         DropdownButton(
//             dropdownColor: kBlackColor,
//             style: Theme.of(context).textTheme.headline4,
//             items: recrutersList
//                 .map(
//                   (recruter) => DropdownMenuItem(
//                     child: Text(recruter.name),
//                     value: recruter.apiName,
//                   ),
//                 )
//                 .toList(),
//             onChanged: _onButtonChanged),
//       ],
//     );
//   }

//   void _onButtonChanged(String? val) {
//     setState(() {
//       value = val;
//     });

//     widget.settingsInfo.updateOneSettingWithKey(quranRecuterKey, val);
//     BlocProvider.of<WerdBloc>(context).add(FetchWerdEvent());
//   }
// }
