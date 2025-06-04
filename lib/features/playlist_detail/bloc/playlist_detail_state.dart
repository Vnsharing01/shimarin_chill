part of 'playlist_detail_bloc.dart';

class PlaylistDetailState extends Equatable {
  final LoadStatus? loadStatus;
  final LoadStatus? loadSoundStatus;
  final AlbumModel? data;
  final List<SoundModel>? sounds;
  final int timerSelected;

  const PlaylistDetailState({
    this.loadStatus = LoadStatus.initial,
    this.loadSoundStatus = LoadStatus.initial,
    this.data,
    this.sounds,
    this.timerSelected = 0,
  });

  PlaylistDetailState copyWith({
    LoadStatus? loadStatus = LoadStatus.initial,
    LoadStatus? loadSoundStatus = LoadStatus.initial,
    AlbumModel? data,
    List<SoundModel>? sounds,
    int? timerSelected,
  }) {
    return PlaylistDetailState(
      loadStatus: loadStatus ?? this.loadStatus,
      loadSoundStatus: loadSoundStatus ?? this.loadSoundStatus,
      data: data ?? this.data,
      sounds: sounds ?? this.sounds,
      timerSelected: timerSelected ?? this.timerSelected,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        loadSoundStatus,
        data,
        sounds,
        timerSelected,
      ];
}
