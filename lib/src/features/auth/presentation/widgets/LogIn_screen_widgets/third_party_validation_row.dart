import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../../../../../core/widgets/app_snackbar.dart';

class ThirdPartyValidationRow extends StatelessWidget {
  const ThirdPartyValidationRow({Key? key}) : super(key: key);

  Widget customIconButton(
    Function onPressedFunc,
    IconData buttonIcon,
  ) {
    return IconButton(
      onPressed: () => onPressedFunc(),
      icon: Icon(
        buttonIcon,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Never trust facebook
        // customIconButton(() async {}, FontAwesome5.facebook),
        customIconButton(() async {
          try {
            // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          } catch (e) {
            showAppDefultSnackbar(context, e.toString().split(":")[1]);
          }
        }, FontAwesome5.google),
      ],
    );
  }
}
