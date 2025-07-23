import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimarin_chill/data/locals/local_hive.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/data/remote/api_client.dart';
import 'package:shimarin_chill/data/repositories/home_repository.dart';
import 'package:shimarin_chill/utils/constants.dart';
import 'package:shimarin_chill/utils/enum/load_status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = ImpHomeRepository(ApiClient());
  HomeBloc() : super(const HomeState()) {
    final localHive = LocalHive();
    on<AddPlaylist>((event, emit) async {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.loading,
        ),
      );
      await downloadDataOnce();
      final listAlbum = localHive.albumBox.values.toList();
      if (listAlbum.isNotEmpty) {
        await Future.delayed(
          const Duration(milliseconds: 1500),
          () {
            emit(
              state.copyWith(
                loadStatus: LoadStatus.success,
                albums: listAlbum,
              ),
            );
          },
        );
      }
    });
  }

  Future<void> downloadDataOnce() async {
    final player = AudioPlayer();
    final localHive = LocalHive();
    final box = Hive.box<SoundModel>('sounds');

    final downloaded = prefs.getBool('downloaded') ?? false;

    if (downloaded) {
      Logger().i('log: Đã tải trước đó, bỏ qua');
      return;
    }

    final soundList = await repository.getDataFromGithub();

    for (var sound in soundList) {
      final urlName = sound.filePath?.split('/').last.replaceAll('.mp3', '');
      final localPath = await downloadFile(sound.filePath!, urlName!);

      await player.setFilePath(localPath);
      final duration = await player.durationStream.firstWhere(
        (element) => element != null,
      );
      sound = sound.copyWith(
        filePath: localPath,
        duration: duration?.inMilliseconds,
      );
      await box.put(sound.id, sound);
    }

    await localHive.initAlbums();

    await prefs.setBool('downloaded', true);

    Logger().f('log: Tải xong toàn bộ, đã lưu vào local');
  }

  Future<String> downloadFile(String url, String filename) async {
    final dio = Dio();
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$filename.mp3';

    if (await File(filePath).exists()) {
      Logger().d('log: Đã tồn tại: $filename');
      return filePath;
    }

    await dio.download(url, filePath);
    Logger().d('log: Đã tải: $filename');
    return filePath;
  }
}
