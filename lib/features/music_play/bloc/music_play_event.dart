part of 'music_play_bloc.dart';

abstract class MusicPlayEvent {}

class InitData extends MusicPlayEvent {
  final List<SoundModel> listMusic;

  InitData({required this.listMusic});
}

class PlayMusic extends MusicPlayEvent {
  final List<SoundModel> listMusic;

  PlayMusic({
    required this.listMusic,
  });
}
