import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/utils/enum/sound_tag_enum.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';
import 'package:shimarin_chill/utils/paths/sounds_path.dart';

class LocalHive {
  final soundPath = "assets/sounds";
  final soundBox = Hive.box<SoundModel>('sounds');
  final albumBox = Hive.box<AlbumModel>('albums');

  final sounds = [];
  final albums = [];

  Future<void> initSounds() async {
    if (soundBox.isNotEmpty) {
      return;
    }

    final player = AudioPlayer();

    for (String url in soundsUrl) {
      try {
        await player.setAsset(url);
        final duration = player.duration?.inSeconds ?? Duration.zero.inSeconds;
        // final avatar = url.split('/').last.replaceAll('.mp3', '').contains(other)

        final sound = SoundModel(
          id: "sound_${soundsUrl.indexOf(url)}",
          duration: duration,
          filePath: url,
          title: url.split('/').last.replaceAll('.mp3', ''),
          coverImage: imgsUrl.first,
        );

        await soundBox.put(sound.id, sound);
      } catch (e) {
        log('❌ Lỗi khi load $url: $e');
      }
    }
  }

  Future<void> initAlbums() async {
    if (albumBox.isNotEmpty) {
      return;
    }

    final chill = soundBox.values
        .where(
          (element) => element.title!.toLowerCase().contains('chill'),
        )
        .toList();
    final coffee = soundBox.values
        .where(
          (element) => element.title!.toLowerCase().contains('coffee'),
        )
        .toList();
    final anime = soundBox.values
        .where(
          (element) => element.title!.toLowerCase().contains('anime'),
        )
        .toList();
    final study = soundBox.values
        .where(
          (element) => element.title!.toLowerCase().contains('study'),
        )
        .toList();
    final rain = soundBox.values
        .where(
          (element) => element.title!.toLowerCase().contains('rain'),
        )
        .toList();

    final albums = [
      AlbumModel(
        id: "album_chill",
        description:
            "Tổng hợp các bài nhạc chill phù hợp cho giải trí và làm làm việc.",
        title: "🎧 Chill",
        coverImage: imgsUrl.firstWhere(
          (element) => element.contains("background"),
          orElse: () => dfImg,
        ),
        soundIds: chill.map<String>((e) => e.id!).toList(),
        tag: SoundTagEnum.chill.key,
      ),
      AlbumModel(
        id: 'album_coffee',
        title: '☕ Coffee',
        description: 'Nhạc lofi nhẹ nhàng cho quán cà phê hoặc làm việc.',
        coverImage: imgsUrl.firstWhere(
          (element) => element.contains("coffee"),
          orElse: () => dfImg,
        ),
        soundIds: coffee.map<String>((e) => e.id!).toList(),
        tag: SoundTagEnum.coffee.key,
      ),
      AlbumModel(
        id: 'album_anime',
        title: '🎌 Anime',
        description: 'Nhạc nền anime truyền cảm hứng.',
        coverImage: imgsUrl.firstWhere(
          (element) => element.toLowerCase().contains("anime"),
          orElse: () => dfImg,
        ),
        soundIds: anime.map<String>((e) => e.id!).toList(),
        tag: SoundTagEnum.anime.key,
      ),
      AlbumModel(
        id: 'album_study',
        title: '📚 Study',
        description: 'Tập trung học tập cùng nhạc không lời.',
        coverImage: imgsUrl.firstWhere(
          (element) => element.toLowerCase().contains("study"),
          orElse: () => dfImg,
        ),
        soundIds: study.map<String>((e) => e.id!).toList(),
        tag: SoundTagEnum.study.key,
      ),
      AlbumModel(
        id: 'album_rain',
        title: '🌧️ Nature & Rain',
        description: 'Âm thanh thiên nhiên giúp thư giãn.',
        coverImage: imgsUrl.firstWhere(
          (element) => element.toLowerCase().contains("rain"),
          orElse: () => dfImg,
        ),
        soundIds: rain.map<String>((e) => e.id!).toList(),
        tag: SoundTagEnum.rain.key,
      ),
    ];

    await albumBox.addAll(albums);
  }
}
