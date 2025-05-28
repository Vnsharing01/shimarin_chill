part of 'home_bloc.dart';

class HomeState extends Equatable {
  final LoadStatus? loadStatus;
  final List<AlbumModel>? albums;

  const HomeState({
    this.loadStatus = LoadStatus.initial,
    this.albums,
  });

  HomeState copyWith({
    LoadStatus? loadStatus = LoadStatus.initial,
    List<AlbumModel>? albums,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      albums: albums ?? this.albums,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        albums,
      ];
}
