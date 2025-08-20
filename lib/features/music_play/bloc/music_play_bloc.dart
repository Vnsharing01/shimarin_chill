import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/utils/enum/load_status.dart';
import 'package:shimarin_chill/utils/enum/play_duration_enum.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';

part 'music_play_event.dart';
part 'music_play_state.dart';

class MusicPlayBloc extends Bloc<MusicPlayEvent, MusicPlayState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  MusicPlayBloc() : super(const MusicPlayState()) {
    audioPlayer.positionStream.listen(
      (position) {
        final duration = audioPlayer.duration ?? Duration.zero;
        add(MusicProccess(
          soundCurrentTime: position,
          soundTotalTime: duration,
        ));
      },
    );

    audioPlayer.processingStateStream.listen(
      (event) async {
        if (event == ProcessingState.completed) {
          audioPlayer.seek(
            Duration.zero,
          );
          audioPlayer.shuffle();

          // chạy playlist
          audioPlayer.play();
        }
      },
    );

    on<InitData>((event, emit) async {
      final duration =
          DurationEnumExtension.getMinutes(event.durationSelected ?? 0);
      emit(state.copyWith(
        sounds: event.listMusic,
        timerSelected: event.durationSelected,
        durationSelected: Duration(minutes: duration),
        urlImage: event.image,
      ));
      await initAudio();
    });

    on<PlayMusic>((event, emit) {});

    on<MusicStop>((event, emit) async {
      audioPlayer.stop();
    });

    on<MusicProccess>((event, emit) {
      emit(state.copyWith(
        soundCurrentTime: event.soundCurrentTime,
        soundTotalTime: event.soundTotalTime,
      ));
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    audioPlayer.dispose();
    return super.close();
  }

  Future<void> initAudio() async {
    // final state = context.watch<MusicPlayBloc>();
    final playlist = ConcatenatingAudioSource(
        shuffleOrder: DefaultShuffleOrder(),
        useLazyPreparation: true,
        children: (state.sounds ?? []).map(
          (path) {
            return AudioSource.file(path.filePath!);
          },
        ).toList());

    // load playlist
    await audioPlayer.setAudioSource(
      playlist,
      preload: true,
    );

    // trộn playlist
    audioPlayer.setShuffleModeEnabled(true);
    audioPlayer.shuffle();

    // chạy playlist
    audioPlayer.play();
  }
}
