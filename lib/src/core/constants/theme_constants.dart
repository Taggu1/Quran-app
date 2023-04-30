import 'package:flutter/material.dart';

import 'colors.dart';

final darkTheme = ThemeData(
  radioTheme:
      RadioThemeData(fillColor: MaterialStateProperty.all(Colors.white)),
  backgroundColor: kBlackColor,
  primaryColor: Colors.amber,
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: ThemeData.light().textTheme.copyWith(
        headline3: const TextStyle(
            wordSpacing: 2,
            fontSize: 30,
            fontFamily: "PdmsSaleemQuranFont",
            color: Colors.white),
        headline4: const TextStyle(
          wordSpacing: 2,
          fontSize: 17,
          color: Colors.white,
        ),
        headline5: const TextStyle(
          wordSpacing: 2,
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
);

final lightTheme = ThemeData(
  backgroundColor: kPrimaryColor,
  iconTheme: const IconThemeData(color: Colors.black),
  primaryColor: Colors.amber,
  textTheme: ThemeData.light().textTheme.copyWith(
        headline3: const TextStyle(
            wordSpacing: 2,
            fontSize: 30,
            fontFamily: "PdmsSaleemQuranFont",
            color: Colors.black),
        headline4:
            const TextStyle(wordSpacing: 2, fontSize: 17, color: Colors.black),
        headline5: const TextStyle(
          wordSpacing: 2,
          fontSize: 13,
          color: Colors.brown,
        ),
      ),
);
