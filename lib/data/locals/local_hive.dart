import 'package:hive_flutter/adapters.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';

class LocalHive {
  final soundPath = "assets/sounds";
  final soundBox = Hive.box<SoundModel>('sounds');
  final albumBox = Hive.box<SoundModel>('albums');

  final sounds = [];
  final albums = [];

  Future<void> initSounds() async {
    final assetsPaths = [
      "$soundPath/chill-lofi-background-music-331434.mp3",
      "$soundPath/coffee-lofi-chill-lofi-music-332738.mp3",
      "$soundPath/echoes-in-the-rain-lofi-music-332825.mp3",
      "$soundPath/lofi-anime-beat-calm-dusk-209897.mp3",
      "$soundPath/lofi-anime-beat-chillax-under-the-stars-209518.mp3",
      "$soundPath/lofi-anime-beat-evening-glow-209896.mp3",
      "$soundPath/lofi-anime-beat-gentle-nightfall-209901.mp3",
      "$soundPath/lofi-anime-beat-golden-hour-harmony-209519.mp3",
      "$soundPath/lofi-anime-beat-mellow-evenings-210701.mp3",
      "$soundPath/lofi-anime-beat-midnight-chill-209899.mp3",
      "$soundPath/lofi-anime-beat-moonlit-serenity-209900.mp3",
      "$soundPath/lofi-anime-beat-silent-thoughts-207784.mp3",
      "$soundPath/lofi-background-music-326931.mp3",
      "$soundPath/lofi-background-music-336230.mp3",
      "$soundPath/lofi-background-music-337568.mp3",
      "$soundPath/lofi-coffee-332824.mp3",
      "$soundPath/lofi-coffee-330550.mp3",
      "$soundPath/lofi-rain-lofi-music-332732.mp3",
      "$soundPath/morning-coffee-lofi-music-340021.mp3",
      "$soundPath/quiet-night-chill-lofi-332744.mp3",
      "$soundPath/rainy-lofi-city-lofi-music-332746.mp3",
    ];
  }
}
