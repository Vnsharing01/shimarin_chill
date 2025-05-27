import 'package:hive_flutter/adapters.dart';
import 'package:shimarin_chill/utils/enum/sound_tag_enum.dart';

part 'sound_model.g.dart';

@HiveType(typeId: 0)
class SoundModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? title; // tên sound

  @HiveField(2)
  final String? filePath; // url sound file

  @HiveField(3)
  final int? duration; // thời gian chạy đếm ngược

  @HiveField(4)
  final String? coverImage; // Ảnh bìa sound

  @HiveField(6)
  final List<String>? albumIds;

  @HiveField(7)
  final List<String>? tags; // Chủ đề như: ["chill", "tập trung"]

  SoundModel({
    this.id,
    this.title,
    this.filePath,
    this.duration,
    this.coverImage,
    this.albumIds,
    this.tags,
  });
}
