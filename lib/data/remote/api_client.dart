import 'package:dio/dio.dart';
import 'package:shimarin_chill/data/remote/api_setup.dart';

class ApiClient {
  final dio = ApiSetup.getDio();

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 0) < 1500;
        },
      ),
    );

    return result;
  }

  Future<Response> put(
    String path, {
    Object? data,
  }) async {
    var result = await dio.put(
      path,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 0) < 1500;
        },
      ),
    );

    return result;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 0) < 1500;
        },
      ),
    );

    return result;
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await dio.delete(
      path,
      queryParameters: queryParameters,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 0) < 1500;
        },
      ),
    );

    return result;
  }
}
