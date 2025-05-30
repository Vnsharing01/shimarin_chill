part of 'playlist_detail_bloc.dart';

class PlaylistDetailState extends Equatable {
  final LoadStatus? loadStatus;
  final LoadStatus? loadSoundStatus;
  final AlbumModel? data;
  final List<SoundModel>? sounds;

  const PlaylistDetailState({
    this.loadStatus = LoadStatus.initial,
    this.loadSoundStatus = LoadStatus.initial,
    this.data,
    this.sounds,
  });

  PlaylistDetailState copyWith({
    LoadStatus? loadStatus = LoadStatus.initial,
    LoadStatus? loadSoundStatus = LoadStatus.initial,
    AlbumModel? data,
    List<SoundModel>? sounds,
  }) {
    return PlaylistDetailState(
      loadStatus: loadStatus ?? this.loadStatus,
      loadSoundStatus: loadSoundStatus ?? this.loadSoundStatus,
      data: data ?? this.data,
      sounds: sounds ?? this.sounds,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        loadSoundStatus,
        data,
        sounds,
      ];
}
