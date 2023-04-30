import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/werd.dart';
import '../bloc/werd/werd_bloc.dart';

class WerdPagePlayButton extends StatefulWidget {
  const WerdPagePlayButton({Key? key}) : super(key: key);

  @override
  State<WerdPagePlayButton> createState() => _WerdPagePlayButtonState();
}

class _WerdPagePlayButtonState extends State<WerdPagePlayButton> {
  @override
  Widget build(BuildContext context) {
    print("builded");
    return BlocBuilder<WerdBloc, WerdState>(
      builder: (context, state) {
        if (state is LoadedWerdState) {
          return FloatingActionButton(
              backgroundColor: Colors.teal.withOpacity(0.8),
              onPressed: () => _onPlayButtonPressed(state.werd),
              child: Icon(
                  state.werd.audio!.playing ? Icons.pause : Icons.play_arrow));
        } else {
          return Container();
        }
      },
    );
  }

  void _onPlayButtonPressed(Werd werd) {
    setState(() {
      werd.audio!.playing ? werd.audio!.pause() : werd.audio?.play();
    });
  }
}
