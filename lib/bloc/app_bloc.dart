import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/data/remote/api_client.dart';
import 'package:shimarin_chill/data/repositories/home_repository.dart';
import 'package:shimarin_chill/utils/constants.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppMainBloc extends Bloc<AppMainEvent, AppMainState> {
  final repository = ImpHomeRepository(ApiClient());
  AppMainBloc()
      : super(AppMainState(isDarkMode: prefs.getBool(darkMode))) {
    on<ChangedThemeMode>((event, emit) {
      emit(state.copyWith(isDarkMode: event.isChanged));
    });
  }

  Future<void> downloadDataOnce() async {
    final box = await Hive.openBox('sound_box');
    final alreadyDownloaded = box.get('downloaded') ?? false;

    if (alreadyDownloaded) {
      print('Đã tải trước đó, bỏ qua');
      return;
    }

    final soundList = await repository.getDataFromGithub();

    List<SoundModel> items = [];

    for (var sound in soundList) {
      final localPath = await downloadFile(sound.filePath!, sound.name!);

      items
          .add(SoundModel(id: sound.id, name: sound.name, filePath: localPath));
    }

    await box.put('sound_items', items.map((e) => e.toJson()).toList());
    await box.put('downloaded', true);

    print('Tải xong toàn bộ, đã lưu vào local');
  }

  Future<String> downloadFile(String url, String filename) async {
  final dio = Dio();
  final dir = await getApplicationDocumentsDirectory();
  final filePath = '${dir.path}/$filename';

  if (await File(filePath).exists()) {
    print('Đã tồn tại: $filename');
    return filePath;
  }

  await dio.download(url, filePath);
  print('Đã tải: $filename');
  return filePath;
}
}
