import 'package:hive_flutter/adapters.dart';
import 'package:shimarin_chill/utils/enum/sound_tag_enum.dart';

@HiveType(typeId: 0)
class SoundModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? filePath;

  @HiveField(3)
  final Duration? duration;

  @HiveField(4)
  final String? coverImage;

  @HiveField(5)
  final DateTime? lastPlayed;

  @HiveField(6)
  final List<String>? albumIds;

  @HiveField(7)
  final List<SoundTagEnum>? tags; // Chủ đề như: ["chill", "tập trung"]

  SoundModel({
    this.id,
    this.title,
    this.filePath,
    this.duration,
    this.coverImage,
    this.lastPlayed,
    this.albumIds,
    this.tags,
  });
}
