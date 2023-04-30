import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../auth/domain/entities/user.dart';
import '../bloc/bloc/user_progress_bloc.dart';
import 'auth_progress_page_title_tile.dart';
import 'user_progress_tile.dart';

class AuthProgressPageWidget extends StatefulWidget {
  final AppUser user;
  const AuthProgressPageWidget({Key? key, required this.user})
      : super(key: key);

  @override
  State<AuthProgressPageWidget> createState() => _AuthProgressPageWidgetState();
}

class _AuthProgressPageWidgetState extends State<AuthProgressPageWidget> {
  @override
  void initState() {
    BlocProvider.of<UserProgressBloc>(context)
        .add(FetchUserProgressEvent(appUser: widget.user));
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const AuthProgressPageTitleTile(),
          BlocBuilder<UserProgressBloc, UserProgressState>(
            builder: (context, state) {
              if (state is UserProgressLoadedState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UserProgressTile(
                      title: AppLocalizations.of(context)!.daysCount,
                      leading: state.userProgress.totalDays.toString(),
                    ),
                    UserProgressTile(
                      title: AppLocalizations.of(context)!.daysStreak,
                      leading: state.userProgress.daysStreak.toString(),
                    ),
                  ],
                );
              } else {
                return const Expanded(child: LoadingWidget());
              }
            },
          ),
        ],
      ),
    );
  }
}
