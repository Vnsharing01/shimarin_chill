part of 'finish_playlist_bloc.dart';

sealed class FinishPlaylistState extends Equatable {
  const FinishPlaylistState();
  
  @override
  List<Object> get props => [];
}

final class FinishPlaylistInitial extends FinishPlaylistState {}
