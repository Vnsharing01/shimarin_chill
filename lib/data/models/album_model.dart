import 'package:hive_flutter/adapters.dart';
import 'package:shimarin_chill/utils/enum/sound_tag_enum.dart';

@HiveType(typeId: 1)
class AlbumModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? coverImage; // asset path

  @HiveField(4)
  final DateTime? lastPlayed;

  @HiveField(5)
  final SoundTagEnum? tags; // Ví dụ: ["anime", "tập trung", "coffee"]

  @HiveField(6) // Danh sách các sound id (liên kết với box<Sound>)
  final List<String>? soundIds;

  @HiveField(7)
  final DateTime? selectedTime; // thời gian hẹn giờ đã chọn

  AlbumModel({
    this.id,
    this.title,
    this.description,
    this.coverImage,
    this.lastPlayed,
    this.tags,
    this.soundIds,
    this.selectedTime,
  });
}
