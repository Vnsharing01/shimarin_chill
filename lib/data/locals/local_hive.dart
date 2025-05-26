import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/utils/enum/sound_tag_enum.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';
import 'package:shimarin_chill/utils/paths/sounds_path.dart';

class LocalHive {
  final soundPath = "assets/sounds";
  final soundBox = Hive.box<SoundModel>('sounds');
  final albumBox = Hive.box<SoundModel>('albums');

  final sounds = [];
  final albums = [];

  Future<void> initSounds() async {
    final player = AudioPlayer();

    for (String url in soundsUrl) {
      try {
        await player.setAsset(url);
        final duration = player.duration ?? Duration.zero;
        // final avatar = url.split('/').last.replaceAll('.mp3', '').contains(other)

        final sound = SoundModel(
          id: "sound_${soundsUrl.indexOf(url)}",
          duration: duration,
          filePath: url,
          title: url.split('/').last.replaceAll('.mp3', ''),
          coverImage: imgsUrl.first,
          albumIds: ["1","2","3"],
          tags: [SoundTagEnum.chill]
        );

        await soundBox.put(sound.id, sound);
      } catch (e) {
        log('❌ Lỗi khi load $url: $e');
      }
    }
  }
}
