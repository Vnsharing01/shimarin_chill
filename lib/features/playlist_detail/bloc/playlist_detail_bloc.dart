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
    on<GetAlbumData>((event, emit) async {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.loading,
        ),
      );
      final data = hiveDB.albumBox.values
          .where(
            (element) => element.id == event.albumId,
          ).single;

      if (data.isInBox) {
        List<SoundModel> listMusic = [];

        for (String id in data.soundIds ?? []) {
          final sound = hiveDB.soundBox.values.singleWhere(
            (element) => element.id == id,
          );
          listMusic.add(sound);
        }

        await Future.delayed(
          const Duration(milliseconds: 1500),
          () {
            emit(
              state.copyWith(
                loadStatus: LoadStatus.success,
                data: data,
                sounds: listMusic,
              ),
            );
          },
        );
      }
    });

    on<ChangedTime>(
      (event, emit) {
        emit(state.copyWith(
          timerSelected: event.value,
        ));
      },
    );
  }
}
