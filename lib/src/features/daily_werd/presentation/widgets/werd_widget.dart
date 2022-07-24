import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quran_app_clean_architecture/src/core/constants/colors.dart';
import 'package:quran_app_clean_architecture/src/core/constants/strings.dart';

import '../../domain/entities/werd.dart';

class WerdWidget extends StatefulWidget {
  final Werd werd;

  const WerdWidget({Key? key, required this.werd}) : super(key: key);

  @override
  State<WerdWidget> createState() => _WerdWidgetState();
}

class _WerdWidgetState extends State<WerdWidget> {
  var selectedAyah = 0;
  late StreamSubscription streamSubscription;
  @override
  void initState() {
    streamSubscription = widget.werd.audio.currentIndexStream.listen((index) {
      if (selectedAyah != index) {
        setState(() {
          selectedAyah = index!;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.werd.audio.pause();
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: kBlackColor,
        padding: const EdgeInsets.all(8),
        child: RichText(
          textAlign: widget.werd.ayahs.length <= 20
              ? TextAlign.center
              : TextAlign.justify,
          text: TextSpan(
            children: [
              for (var i = 0; i < widget.werd.ayahs.length; i++) ...{
                _buildAyah(
                    ayahString: widget.werd.ayahs[i].text,
                    index: i,
                    context: context),
                _buildAyahSymbol(i)
              }
            ],
          ),
        ),
      ),
    );
  }

  WidgetSpan _buildAyahSymbol(int index) {
    return WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: CircleAvatar(
          backgroundImage: const AssetImage(
            "assets/images/quran_ayah_sympol.png",
          ),
          backgroundColor: Colors.white,
          child: Text(
            '${widget.werd.ayahs[index].numberInSurah}',
            textAlign: TextAlign.center,
            textScaleFactor: index.toString().length <= 2 ? 1 : .8,
            style: const TextStyle(color: Colors.black),
          ),
          radius: 14,
        ));
  }

  TextSpan _buildAyah(
      {required BuildContext context,
      required String ayahString,
      required int index}) {
    if (ayahString.startsWith(basmalaPattern))
      ayahString = ayahString.split(" ").last;
    return TextSpan(
        recognizer: _ayahSpanGestureRecognizer(index),
        text: ' ' + ayahString + ' ',
        style: Theme.of(context).textTheme.headline3?.copyWith(
              color: index == selectedAyah ? kBrightYellow : kPrimaryColor,
            ));
  }

  LongPressGestureRecognizer _ayahSpanGestureRecognizer(int index) {
    return LongPressGestureRecognizer()
      ..onLongPress = () {
        setState(() {
          widget.werd.audio.seek(null, index: index);
        });
      };
  }
}
