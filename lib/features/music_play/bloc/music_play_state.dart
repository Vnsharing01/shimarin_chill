part of 'music_play_bloc.dart';

class MusicPlayState extends Equatable {
  final LoadStatus? loadStatus;
  final List<SoundModel>? sounds;
  final int timerSelected;
  final Duration durationSelected;
  final Duration soundCurrentTime;
  final Duration soundTotalTime;
  final String urlImage;

  const MusicPlayState({
    this.loadStatus = LoadStatus.initial,
    this.sounds,
    this.timerSelected = 0,
    this.durationSelected = Duration.zero,
    this.soundCurrentTime = Duration.zero,
    this.soundTotalTime = Duration.zero,
    this.urlImage = dfImg,
  });

  MusicPlayState copyWith({
    LoadStatus? loadStatus = LoadStatus.initial,
    List<SoundModel>? sounds,
    int? timerSelected,
    final Duration? durationSelected,
    final Duration? soundCurrentTime,
    final Duration? soundTotalTime,
    final String? urlImage,
  }) {
    return MusicPlayState(
      loadStatus: loadStatus ?? this.loadStatus,
      sounds: sounds ?? this.sounds,
      timerSelected: timerSelected ?? this.timerSelected,
      durationSelected: durationSelected ?? this.durationSelected,
      soundCurrentTime: soundCurrentTime ?? this.soundCurrentTime,
      soundTotalTime: soundTotalTime ?? this.soundTotalTime,
      urlImage: urlImage ?? this.urlImage,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        sounds,
        timerSelected,
        durationSelected,
        soundCurrentTime,
        soundTotalTime,
        urlImage,
      ];
}
