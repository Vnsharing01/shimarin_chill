
import 'package:hive_flutter/adapters.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/utils/enum/sound_tag_enum.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';

class LocalHive {
  final soundPath = "assets/sounds";
  final soundBox = Hive.box<SoundModel>('sounds');
  final albumBox = Hive.box<AlbumModel>('albums');

  final sounds = [];
  final albums = [];

  // Future<void> initSounds() async {
  //   if (soundBox.isNotEmpty) {
  //     return;
  //   }

  //   final player = AudioPlayer();

  //   for (String url in soundsUrl) {
  //     try {
  //       await player.setAsset(url);
  //       final duration = await player.durationStream.firstWhere(
  //         (element) => element != null,
  //       );
  //       // final avatar = url.split('/').last.replaceAll('.mp3', '').contains(other)

  //       final sound = SoundModel(
  //         id: "sound_${soundsUrl.indexOf(url)}",
  //         duration: duration?.inMilliseconds,
  //         filePath: url,
  //         name: url.split('/').last.replaceAll('.mp3', ''),
  //       );

  //       await soundBox.put(sound.id, sound);
  //     } catch (e) {
  //       log('❌ Lỗi khi load $url: $e');
  //     }
  //   }
  // }

  Future<void> initAlbums() async {
    if (albumBox.isNotEmpty) {
      return;
    }

    final chill = soundBox.values
        .where(
          (element) => element.name!.toLowerCase().contains('chill'),
        )
        .toList();
    final coffee = soundBox.values
        .where(
          (element) => element.name!.toLowerCase().contains('coffee'),
        )
        .toList();
    final anime = soundBox.values
        .where(
          (element) => element.name!.toLowerCase().contains('anime'),
        )
        .toList();
    final study = soundBox.values
        .where(
          (element) => element.name!.toLowerCase().contains('study'),
        )
        .toList();
    final rain = soundBox.values
        .where(
          (element) => element.name!.toLowerCase().contains('rain'),
        )
        .toList();

    final albums = [
      AlbumModel(
        id: "album_chill",
        description:
            "Thư giãn với những bản nhạc chill nhẹ nhàng, lý tưởng để giải tỏa căng thẳng và tạo không gian làm việc yên bình.",
        title: "🌿 Chill",
        coverImage: imgsUrl.firstWhere(
          (element) => element.contains("background"),
          orElse: () => dfImg,
        ),
        sounds: chill,
        tag: SoundTagEnum.chill.key,
      ),
      AlbumModel(
        id: 'album_coffee',
        title: '☕ Coffee',
        description: 'Hòa mình vào không gian quán cà phê với giai điệu lofi êm dịu, giúp bạn tập trung và khơi gợi cảm hứng làm việc.',
        coverImage: imgsUrl.firstWhere(
          (element) => element.contains("coffee"),
          orElse: () => dfImg,
        ),
        sounds: coffee,
        tag: SoundTagEnum.coffee.key,
      ),
      AlbumModel(
        id: 'album_anime',
        title: '🌸 Anime',
        description: 'Đắm chìm trong thế giới anime cùng những bản nhạc nền truyền cảm hứng, đầy màu sắc và cảm xúc.',
        coverImage: imgsUrl.firstWhere(
          (element) => element.toLowerCase().contains("anime"),
          orElse: () => dfImg,
        ),
        sounds: anime,
        tag: SoundTagEnum.anime.key,
      ),
      AlbumModel(
        id: 'album_study',
        title: '📝 Study',
        description: 'Tập trung tối đa với nhạc không lời dịu nhẹ, hỗ trợ tăng cường sự chú ý và duy trì năng suất học tập lâu dài.',
        coverImage: imgsUrl.firstWhere(
          (element) => element.toLowerCase().contains("study"),
          orElse: () => dfImg,
        ),
        sounds: study,
        tag: SoundTagEnum.study.key,
      ),
      AlbumModel(
        id: 'album_rain',
        title: '🌧️ Rain',
        description: 'Thư giãn sâu với bản nhạc nền kết hợp tiếng mưa rơi, mang lại cảm giác dễ chịu và nhẹ nhàng như một buổi chiều bình yên bên hiên nhà.',
        coverImage: imgsUrl.firstWhere(
          (element) => element.toLowerCase().contains("rain"),
          orElse: () => dfImg,
        ),
        sounds: rain,
        tag: SoundTagEnum.rain.key,
      ),
    ];

    await albumBox.addAll(albums);
  }
}
