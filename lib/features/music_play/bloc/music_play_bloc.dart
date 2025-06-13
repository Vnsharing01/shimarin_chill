import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/utils/enum/load_status.dart';

part 'music_play_event.dart';
part 'music_play_state.dart';

class MusicPlayBloc extends Bloc<MusicPlayEvent, MusicPlayState> {
  MusicPlayBloc() : super(const MusicPlayState()) {
    on<InitData>(
      (event, emit) => emit(state.copyWith(sounds: event.listMusic)),
    );
    on<PlayMusic>((event, emit) {
      
    });
  }
}
