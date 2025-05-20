import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'playlist_detail_event.dart';
part 'playlist_detail_state.dart';

class PlaylistDetailBloc extends Bloc<PlaylistDetailEvent, PlaylistDetailState> {
  PlaylistDetailBloc() : super(PlaylistDetailInitial()) {
    on<PlaylistDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
