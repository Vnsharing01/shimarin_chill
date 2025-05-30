import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimarin_chill/data/locals/local_hive.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/utils/enum/load_status.dart';

part 'playlist_detail_event.dart';
part 'playlist_detail_state.dart';

class PlaylistDetailBloc
    extends Bloc<PlaylistDetailEvent, PlaylistDetailState> {
  PlaylistDetailBloc() : super(const PlaylistDetailState()) {
    final hiveDB = LocalHive();
    on<GetAlbumData>((event, emit) {
      emit(
        const PlaylistDetailState().copyWith(
          loadStatus: LoadStatus.loading,
        ),
      );
      final data = hiveDB.albumBox.values
          .where(
            (element) => element.id == event.albumId,
          )
          .single;

      emit(
        const PlaylistDetailState().copyWith(
          loadStatus: LoadStatus.success,
          data: data,
        ),
      );
    });
    on<GetListSounds>((event, emit) {
      // TODO: implement event handler
    });
  }
}
