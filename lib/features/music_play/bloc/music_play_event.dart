part of 'music_play_bloc.dart';

abstract class MusicPlayEvent {}

class InitData extends MusicPlayEvent {
  final List<SoundModel> listMusic;
  final int? durationSelected;
  final String? image;

  InitData({
    required this.listMusic,
    this.durationSelected,
    this.image,
  });
}

class PlayMusic extends MusicPlayEvent {
  final List<SoundModel> listMusic;

  PlayMusic({
    required this.listMusic,
  });
}

class MusicProccess extends MusicPlayEvent {
  final Duration? soundCurrentTime;
  final Duration? soundTotalTime;

  MusicProccess({
    this.soundCurrentTime,
    this.soundTotalTime,
  });
}

class MusicStop extends MusicPlayEvent {}
