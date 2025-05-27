import 'package:hive_flutter/adapters.dart';
import 'package:shimarin_chill/utils/enum/sound_tag_enum.dart';

part 'album_model.g.dart';

@HiveType(typeId: 1)
class AlbumModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title; // tên chủ đề

  @HiveField(2)
  final String? description; //Mô tả album

  @HiveField(3)
  final String? coverImage; // Ảnh bìa album

  @HiveField(4)
  final DateTime? lastPlayed; // Lần cuối mở album này

  @HiveField(5)
  final String? tag; // Ví dụ: ["anime", "tập trung", "coffee"]

  @HiveField(6) // Danh sách các sound id (liên kết với box<Sound>)
  final List<String>? soundIds;

  @HiveField(7)
  final int? selectedTime; // thời gian hẹn giờ đã chọn

  AlbumModel({
    this.id,
    this.title,
    this.description,
    this.coverImage,
    this.lastPlayed,
    this.tag,
    this.soundIds,
    this.selectedTime,
  });
}
