part of 'playlist_detail_bloc.dart';

abstract class PlaylistDetailEvent {}

class GetAlbumData extends PlaylistDetailEvent {
  final String albumId;

  GetAlbumData({
    required this.albumId,
  });
}

class ChangedTime extends PlaylistDetailEvent {
  final int value;

  ChangedTime({
    required this.value,
  });
}
