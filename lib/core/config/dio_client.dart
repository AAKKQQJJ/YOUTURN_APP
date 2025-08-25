import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://52.78.232.250:80', // 공통 도메인
      connectTimeout: const Duration(seconds: 30), // 연결 시간: 30초 (챗봇 고려)
      receiveTimeout: const Duration(seconds: 10),  // 기본 응답 시간: 10초 (개별 설정으로 오버라이드)
      sendTimeout: const Duration(seconds: 30),     // 기본 전송 시간: 30초
      contentType: 'application/json',
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      LogInterceptor(responseBody: true), // 디버깅용
    ]);
}
