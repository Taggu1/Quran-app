import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../widgets/auth_progress_page_widget.dart';
import '../widgets/un_auth_progress_page_widget.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is AuthedState) {
          return AuthProgressPageWidget(user: state.appUser);
        } else {
          return const UnAuthProgressPageWidget();
        }
      },
    );
  }
}
