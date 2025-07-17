import 'dart:convert';

import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/data/remote/api_client.dart';
import 'package:shimarin_chill/data/remote/api_endpoint.dart';

abstract class HomeRepository {
  Future<List<SoundModel>> getDataFromGithub();
}

class ImpHomeRepository extends HomeRepository {
  final ApiClient apiClient;

  ImpHomeRepository(this.apiClient);

  @override
  Future<List<SoundModel>> getDataFromGithub() async {
    final res = await apiClient.get(
      ApiEndpoint.soundList,
    );
    final List<dynamic> data = jsonDecode(res.data);
    if (res.statusCode != 200) {
      return [];
    } else {
      return data.map((json) => SoundModel.fromJson(json)).toList();
    }
  }
}
