import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/werd/werd_bloc.dart';
import '../widgets/ruku_data_widget.dart';
import '../widgets/werd_page_play_button.dart';
import '../widgets/werd_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: _buildBody(),
      ),
    );
  }

  BlocBuilder<WerdBloc, WerdState> _buildBody() {
    return BlocBuilder<WerdBloc, WerdState>(
      builder: (context, state) {
        if (state is LoadingWerdState) {
          return const LoadingWidget();
        } else if (state is LoadedWerdState) {
          print(state.werd.audio?.duration);
          return SingleChildScrollView(
            child: Column(
              children: [
                RukuDataWidget(
                  surah: state.werd.surah,
                  page: state.werd.page,
                  hizab: state.werd.hizab,
                  juz: state.werd.juz,
                ),
                WerdWidget(
                  werd: state.werd,
                ),
              ],
            ),
          );
        } else if (state is FailureWerdState) {
          return Center(child: Text(state.message));
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
