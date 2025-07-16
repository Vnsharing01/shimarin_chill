import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/data/remote/api_client.dart';
import 'package:shimarin_chill/data/remote/api_endpoint.dart';

abstract class HomeRepository {}

class ImpHomeRepository extends HomeRepository {
  final _apiClient = ApiClient();

  Future<List<SoundModel>> getDataFromGithub() async {
    final res = await _apiClient.get(
      ApiEndpoint.soundList,
    );
    final List<dynamic> data = res.data;
    if (res.statusCode != 200) {
      return [];
    } else {
      return data.map((json) => SoundModel.fromJson(json)).toList();
    }
  }
}
