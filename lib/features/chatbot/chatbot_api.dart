import 'package:dio/dio.dart';
import 'package:youturn/core/config/dio_client.dart';

import '../../core/const/api_routes.dart';

class ChatbotApi {
  static Future<String> sendMessage(String message, String accessToken) async {
    print('=== 챗봇 API 요청 ===');
    print('URL: ${ApiRoutes.chatbotMessage}');
    print('Message: $message');
    print('AccessToken: ${accessToken.substring(0, 20)}...');

    // 요청 데이터 검증
    if (message.trim().isEmpty) {
      throw Exception('메시지는 비어있을 수 없습니다.');
    }
    
    final requestData = {
      'prompt': message.trim(),
      "model": "gpt-oss:20b",
    };
    
    print('Request Data: $requestData');

    try {
      final response = await DioClient.dio.post(
        ApiRoutes.chatbotMessage,
        data: requestData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
          receiveTimeout: const Duration(minutes: 3),   // LLM 응답 대기 시간: 3분으로 증가
          sendTimeout: const Duration(minutes: 1),      // 요청 전송 시간: 1분
          validateStatus: (status) {
            // 200, 201만 성공으로 처리, 다른 코드는 예외 발생
            return status != null && status >= 200 && status < 300;
          },
        ),
      );

      print('=== 챗봇 API 응답 ===');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        // API 명세서에 맞는 응답 구조 파싱
        if (responseData is Map<String, dynamic>) {
          // 우선순위: response > data.response > message > reply (기존)
          if (responseData.containsKey('response') && responseData['response'] != null) {
            final botResponse = responseData['response'] as String;
            print('챗봇 응답 추출 성공 (response)');
            return botResponse;
          } else if (responseData.containsKey('data') &&
              responseData['data'] is Map<String, dynamic> &&
              responseData['data']['response'] != null) {
            final botResponse = responseData['data']['response'] as String;
            print('챗봇 응답 추출 성공 (data.response)');
            return botResponse;
          } else if (responseData.containsKey('message')) {
            return responseData['message'] as String;
          } else if (responseData.containsKey('reply')) {
            return responseData['reply'] as String; // 기존 호환성
          } else {
            throw Exception('응답에서 메시지를 찾을 수 없습니다: $responseData');
          }
        } else {
          throw Exception('예상치 못한 응답 형식: ${responseData.runtimeType}');
        }
      } else {
        throw Exception('챗봇 응답 실패: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('=== 챗봇 API DioException ===');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      
      if (e.response?.statusCode == 500) {
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
          throw Exception('서버 오류: ${errorData['message']}');
        } else {
          throw Exception('서버 내부 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
        }
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('AI 응답 시간이 초과되었습니다. 네트워크 상태를 확인하고 다시 시도해주세요.');
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw Exception('요청 전송 시간이 초과되었습니다. 네트워크 상태를 확인해주세요.');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('서버 연결에 실패했습니다. 네트워크 상태를 확인해주세요.');
      } else {
        throw Exception('네트워크 오류: ${e.message}');
      }
    } catch (e) {
      print('=== 챗봇 API 일반 예외 ===');
      print('Error: $e');
      throw Exception('예상치 못한 오류가 발생했습니다: $e');
    }
  }
}
