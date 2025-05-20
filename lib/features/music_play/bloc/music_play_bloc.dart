import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'music_play_event.dart';
part 'music_play_state.dart';

class MusicPlayBloc extends Bloc<MusicPlayEvent, MusicPlayState> {
  MusicPlayBloc() : super(MusicPlayInitial()) {
    on<MusicPlayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
