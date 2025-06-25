import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/features/music_play/bloc/music_play_bloc.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/utils/enum/play_duration_enum.dart';
import 'package:shimarin_chill/utils/formats/formats_time.dart';
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

class _MusicPlayPageState extends State<MusicPlayPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );
    context.read<MusicPlayBloc>().add(
          InitData(
            listMusic: widget.arguments?.sounds ?? [],
            durationSelected: widget.arguments?.durationSelected,
          ),
        );

    // xoay ngang màn hình
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        debugPrint("⏰ Đã hết thời gian");
        context.read<MusicPlayBloc>().add(MusicStop());
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    // xoay dọc màn hình
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    context.read<MusicPlayBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    final duration =
        _animationController.duration! * _animationController.value;

    return BlocConsumer<MusicPlayBloc, MusicPlayState>(
      listenWhen: (previous, current) =>
          previous.durationSelected != current.durationSelected,
      listener: (context, state) {
        if (duration > Duration.zero) {
          _startDuration(state.durationSelected);
        } else {
          _animationController.stop();
        }
      },
      builder: (context, state) {
        final bloc = context.read<MusicPlayBloc>();

        if (state.soundTotalTime.inMilliseconds > 0) {
          progress = state.soundCurrentTime.inMilliseconds /
              state.soundTotalTime.inMilliseconds;
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
                  image: AssetImage(state.sounds?.last.coverImage ?? dfImg),
                  fit: BoxFit.fill),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(top: 24),
                  child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (_, __) {
                        return Text(
                          state.timerSelected == PlayDurationEnum.none.key
                              ? formatDurationMMSS(state.soundCurrentTime)
                              : formatDurationMMSS(duration),
                          style: AppTextStyle.timeDuration(
                            size: 102,
                            color: Colors.white,
                          ),
                        );
                      }),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: LinearProgressIndicator(
                    minHeight: 12,
                    borderRadius: BorderRadius.circular(8),
                    value: progress.clamp(0.0, 1.0),
                    backgroundColor: Colors.grey.withOpacity(0.5),
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

  void _startDuration(Duration duration) {
    _animationController.duration = duration;
    _animationController.reverse(from: 1.0);
  }
}
