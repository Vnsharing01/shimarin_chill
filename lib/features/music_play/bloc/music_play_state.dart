part of 'music_play_bloc.dart';

class MusicPlayState extends Equatable {
  final LoadStatus? loadStatus;
  final List<SoundModel>? sounds;
  final int timerSelected;
  final Duration soundCurrentTime;
  final Duration soundTotalTime;

  const MusicPlayState( {
    this.loadStatus = LoadStatus.initial,
    this.sounds,
    this.timerSelected = 0,
    this.soundCurrentTime = Duration.zero, this.soundTotalTime= Duration.zero,
  });

  MusicPlayState copyWith({
    LoadStatus? loadStatus = LoadStatus.initial,
    List<SoundModel>? sounds,
    int? timerSelected,
    final Duration ?soundCurrentTime,
  final Duration? soundTotalTime,
  }) {
    return MusicPlayState(
      loadStatus: loadStatus ?? this.loadStatus,
      sounds: sounds ?? this.sounds,
      timerSelected: timerSelected ?? this.timerSelected,
      soundCurrentTime: soundCurrentTime ?? this.soundCurrentTime,
      soundTotalTime: soundTotalTime ?? this.soundTotalTime,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        sounds,
        timerSelected,
        soundCurrentTime,
      ];
}
