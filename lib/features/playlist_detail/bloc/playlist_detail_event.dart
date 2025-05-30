part of 'playlist_detail_bloc.dart';

abstract class PlaylistDetailEvent {}

class GetAlbumData extends PlaylistDetailEvent {
  final String albumId;

  GetAlbumData({
    required this.albumId,
  });
}

class GetListSounds extends PlaylistDetailEvent {
  final List<String> soundIds;

  GetListSounds({
    required this.soundIds,
  });
}
