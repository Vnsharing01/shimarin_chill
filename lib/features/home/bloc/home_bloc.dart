import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shimarin_chill/data/locals/local_hive.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/utils/enum/load_status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    final localHive = LocalHive();
    on<AddPlaylist>((event, emit) {
      emit(
        const HomeState().copyWith(
          loadStatus: LoadStatus.loading,
        ),
      );
      final listAlbum = localHive.albumBox.values.toList();
      emit(
        const HomeState().copyWith(
          loadStatus: LoadStatus.success,
          albums: listAlbum,
        ),
      );
    });
  }
}
