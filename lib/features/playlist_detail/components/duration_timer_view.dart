import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimarin_chill/features/playlist_detail/bloc/playlist_detail_bloc.dart';
import 'package:shimarin_chill/widgets/button/btn_radio.dart';

class DurationTimerView extends StatefulWidget {
  const DurationTimerView({super.key});

  @override
  State<DurationTimerView> createState() => _DurationTimerViewState();
}

class _DurationTimerViewState extends State<DurationTimerView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaylistDetailBloc, PlaylistDetailState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final bloc = context.read<PlaylistDetailBloc>();
        return Column(
          children: [
            BtnRadio(
              value: 1,
              selected: state.timerSelected,
              onTap: (value) {
                bloc.add(ChangedTime(
                  value: value,
                ));
              },
            ),
            BtnRadio(
              value: 2,
              selected: state.timerSelected,
              onTap: (value) { bloc.add(ChangedTime(
                  value: value,
                ));},
            ),
            BtnRadio(
              value: 3,
              selected: state.timerSelected,
              onTap: (value) { bloc.add(ChangedTime(
                  value: value,
                ));},
            ),
          ],
        );
      },
    );
  }
}
