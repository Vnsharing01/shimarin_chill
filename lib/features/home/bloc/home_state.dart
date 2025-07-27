part of 'home_bloc.dart';

class HomeState extends Equatable {
  final LoadStatus? loadStatus;
  final List<AlbumModel>? albums;
  final bool isFirstDownload;

  const HomeState({
    this.loadStatus = LoadStatus.initial,
    this.albums,
    this.isFirstDownload = false,
  });

  HomeState copyWith({
    LoadStatus? loadStatus = LoadStatus.initial,
    List<AlbumModel>? albums,
    bool? isFirstDownload,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      albums: albums ?? this.albums,
      isFirstDownload: isFirstDownload ?? this.isFirstDownload,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        albums,
        isFirstDownload,
      ];
}
