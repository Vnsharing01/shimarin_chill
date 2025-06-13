part of 'music_play_bloc.dart';

class MusicPlayState extends Equatable {
  final LoadStatus? loadStatus;
  final List<SoundModel>? sounds;
  final int timerSelected;

  const MusicPlayState({
    this.loadStatus = LoadStatus.initial,
    this.sounds,
    this.timerSelected = 0,
  });

  MusicPlayState copyWith({
    LoadStatus? loadStatus = LoadStatus.initial,
    List<SoundModel>? sounds,
    int? timerSelected,
  }) {
    return MusicPlayState(
      loadStatus: loadStatus ?? this.loadStatus,
      sounds: sounds ?? this.sounds,
      timerSelected: timerSelected ?? this.timerSelected,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        sounds,
        timerSelected,
      ];
}
