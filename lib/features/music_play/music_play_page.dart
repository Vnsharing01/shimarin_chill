import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/features/music_play/bloc/music_play_bloc.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';
import 'package:shimarin_chill/widgets/app_bar/df_appbar.dart';

class PlayArguments {
  final int durationSelected;
  final List<SoundModel> sounds;

  PlayArguments({
    required this.durationSelected,
    required this.sounds,
  });
}

class MusicPlayPage extends StatefulWidget {
  const MusicPlayPage({
    super.key,
    this.arguments,
  });

  final PlayArguments? arguments;

  @override
  State<MusicPlayPage> createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> {
  @override
  void initState() {
    super.initState();

    context.read<MusicPlayBloc>().add(
          InitData(listMusic: widget.arguments?.sounds ?? []),
        );

    // xoay ngang màn hình
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // xoay dọc màn hình
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    context.read<MusicPlayBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicPlayBloc, MusicPlayState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = context.read<MusicPlayBloc>();
        double progress = 0;

        if (state.soundTotalTime.inMicroseconds > 0) {
          progress = state.soundCurrentTime.inMicroseconds /
              state.soundTotalTime.inMicroseconds;
        }

        return Scaffold(
          appBar: iconWhiteAppBar(
            context: context,
            title: '',
            onBack: () {
              bloc.add(MusicStop());
            },
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(

                  /// TODO: ảnh thay đổi theo nhạc
                  image: AssetImage(state.sounds?.first.coverImage ?? dfImg),
                  fit: BoxFit.fill),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    "3:45",
                    style: AppTextStyle.timeDuration(
                      size: 102,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200),
                  child: LinearProgressIndicator(
                    minHeight: 12,
                    borderRadius: BorderRadius.circular(8),
                    value: progress.clamp(0.0, 0.1),
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
