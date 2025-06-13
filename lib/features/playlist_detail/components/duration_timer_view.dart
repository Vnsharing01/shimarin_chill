import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimarin_chill/features/playlist_detail/bloc/playlist_detail_bloc.dart';
import 'package:shimarin_chill/utils/enum/play_duration_enum.dart';
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
      },
      builder: (context, state) {
        final bloc = context.read<PlaylistDetailBloc>();
        return Column(
          children: [
            const SizedBox(height: 16),
            BtnRadio(
              value: 1,
              selected: state.timerSelected,
              txtTitle: PlayDurationEnum.minutes25.title,
              onTap: (value) {
                bloc.add(ChangedTime(
                  value: value,
                ));
              },
            ),
            BtnRadio(
              value: 2,
              selected: state.timerSelected,
              txtTitle: PlayDurationEnum.minutes35.title,
              onTap: (value) {
                bloc.add(ChangedTime(
                  value: value,
                ));
              },
            ),
            BtnRadio(
              value: 3,
              selected: state.timerSelected,
              txtTitle: PlayDurationEnum.minutes45.title,
              onTap: (value) {
                bloc.add(ChangedTime(
                  value: value,
                ));
              },
            ),
            BtnRadio(
              value: 0,
              selected: state.timerSelected,
              txtTitle: PlayDurationEnum.none.title,
              onTap: (value) {
                bloc.add(ChangedTime(
                  value: value,
                ));
              },
            ),
          ],
        );
      },
    );
  }
}
