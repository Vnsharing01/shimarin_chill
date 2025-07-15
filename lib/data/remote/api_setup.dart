import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shimarin_chill/utils/constants.dart';

class ApiSetup {
  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio?.options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: true,
        maxRedirects: 100,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      );
      dio?.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          // Xử lý trước khi gửi request
          Logger().t('Request [${options.method}] => PATH: ${options.path}');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Xử lý khi nhận được response
          Logger()
              .f('Response [${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          // Xử lý khi có lỗi
          Logger().e('Error: ${error.message}');
          return handler.next(error);
        },
      ));
    }
    return dio!;
  }
}
