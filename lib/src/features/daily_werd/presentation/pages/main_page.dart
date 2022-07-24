import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app_clean_architecture/src/core/constants/colors.dart';
import 'package:quran_app_clean_architecture/src/features/daily_werd/presentation/widgets/werd_page_play_button.dart';
import 'package:quran_app_clean_architecture/src/features/settings/presentation/bloc/settings_bloc/settings_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/werd.dart';
import '../bloc/werd/werd_bloc.dart';
import '../widgets/werd_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("BUilded");
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBlackColor,
          body: _buildBody(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const WerdPagePlayButton()),
    );
  }

  BlocBuilder<WerdBloc, WerdState> _buildBody() {
    return BlocBuilder<WerdBloc, WerdState>(
      builder: (context, state) {
        if (state is LoadingWerdState) {
          return const LoadingWidget();
        } else if (state is LoadedWerdState) {
          return WerdWidget(
            werd: state.werd,
          );
        } else {
          return const Center(child: Text("Error"));
        }
      },
    );
  }
}
