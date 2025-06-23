import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'finish_playlist_event.dart';
part 'finish_playlist_state.dart';

class FinishPlaylistBloc extends Bloc<FinishPlaylistEvent, FinishPlaylistState> {
  FinishPlaylistBloc() : super(FinishPlaylistInitial()) {
    on<FinishPlaylistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
