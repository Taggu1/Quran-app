import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../auth/domain/repositories/auth_repo.dart';
import '../../../auth/presentation/auth_bloc/auth_bloc.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _onPressed(context),
      icon: const Icon(Icons.circle),
      label: Text(
        AppLocalizations.of(context)!.signInWithGoogleLabel,
        style: Theme.of(context).textTheme.headline4,
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      const LogInWithThirdPartyEvent(thirdParty: ThirdParty.google),
    );
  }
}
