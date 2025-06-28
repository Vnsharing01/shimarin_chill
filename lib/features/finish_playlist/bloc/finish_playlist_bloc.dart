
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'finish_playlist_event.dart';
part 'finish_playlist_state.dart';

class FinishPlaylistBloc
    extends Bloc<FinishPlaylistEvent, FinishPlaylistState> {
  FinishPlaylistBloc() : super(const FinishPlaylistState()) {
    on<FinishPlaylistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
