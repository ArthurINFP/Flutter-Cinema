import 'package:cinema/core/utils/dotenv.dart';
import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  final baseURL = 'https://api.themoviedb.org/3';

  void initDio() {
    dio = Dio();
    dio.options = BaseOptions(
        baseUrl: baseURL, receiveTimeout: const Duration(seconds: 8));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters.addAll({'api_key': DotEnvUtils.apiKey});
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }
}
