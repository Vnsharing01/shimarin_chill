import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sound_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class SoundModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? title; // tên sound

  @HiveField(2)
  final String? filePath; // url sound file

  @HiveField(3)
  final int? duration; // thời gian chạy đếm ngược

  SoundModel({
    this.id,
    this.title,
    this.filePath,
    this.duration,
  });

    factory SoundModel.fromJson(Map<String, dynamic> json) =>
      _$SoundModelFromJson(json);

  Map<String, dynamic> toJson(List<SoundModel> sounds) => _$SoundModelToJson(this);
}
