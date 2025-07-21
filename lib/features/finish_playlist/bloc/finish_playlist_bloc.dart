import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'finish_playlist_event.dart';
part 'finish_playlist_state.dart';

class FinishPlaylistBloc
    extends Bloc<FinishPlaylistEvent, FinishPlaylistState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  FinishPlaylistBloc() : super(const FinishPlaylistState()) {
    on<PlayFinishSound>((event, emit) async {
      await initAudio();
    });
  }

  Future<void> initAudio() async {
    await audioPlayer.setAudioSource(
      AudioSource.asset("assets/sounds/completed_flute.mp3"),
      preload: true,
    );

    // chạy playlist
    await audioPlayer.play();
    await audioPlayer.stop();
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
