part of 'playlist_detail_bloc.dart';

abstract class PlaylistDetailEvent {}

class GetAlbumData extends PlaylistDetailEvent {
  final String albumId;

  GetAlbumData({
    required this.albumId,
  });
}
