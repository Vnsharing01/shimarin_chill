import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 1)
class AlbumModel extends HiveObject{
  final String? name;
  final String? image;
  final List<String>? sounds;
  final String? time;

  AlbumModel({
    this.name,
    this.image,
    this.sounds,
    this.time,
  });

  AlbumModel copyWith({
    String? name,
    String? image,
    List<String>? sounds,
    String? time,
  }) {
    return AlbumModel(
      name: name ?? this.name,
      image: image ?? this.image,
      sounds: sounds ?? this.sounds,
      time: time ?? this.time,
    );
  }
}
