import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://your-api-server.com', // 공통 도메인
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      contentType: 'application/json',
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      LogInterceptor(responseBody: true), // 디버깅용
    ]);
}
