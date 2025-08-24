import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/dio_provider.dart';
import 'consulting_data.dart';

final consultingRepositoryProvider = Provider<ConsultingRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ConsultingRepository(dio);
});

class ConsultingRepository {
  final Dio dio;

  ConsultingRepository(this.dio);

  Future<int> submitConsultingInfo({
    required int usersId,
    required ConsultingData data,
  }) async {
    try {
      print('=== API 요청 데이터 디버깅 ===');
      print('Request URL: /v1/information');
      
      final response = await dio.post(
        '/v1/information',
        data: data.toApiJson(userId: usersId),
      );

      print('Response: ${response.data}');
      print('Response type: ${response.data.runtimeType}');
      
      // 응답 구조 확인 및 information_id 추출
      final responseData = response.data;
      int infoId;
      
      if (responseData is Map<String, dynamic>) {
        if (responseData.containsKey('data') && responseData['data'] != null) {
          // 중첩 구조: {data: {information_id: 1}}
          infoId = responseData['data']['information_id'];
          print('중첩 구조에서 information_id 추출: $infoId');
        } else if (responseData.containsKey('information_id')) {
          // 평면 구조: {information_id: 1}
          infoId = responseData['information_id'];
          print('평면 구조에서 information_id 추출: $infoId');
        } else {
          throw Exception('응답에서 information_id를 찾을 수 없습니다: $responseData');
        }
      } else {
        throw Exception('예상치 못한 응답 타입: ${responseData.runtimeType}');
      }
      
      return infoId; // LLM 요청 시에 이 ID 사용됨
    } catch (e) {
      print('정보 제출 실패: $e');
      if (e is DioException) {
        print('응답 상태 코드: ${e.response?.statusCode}');
        print('응답 데이터: ${e.response?.data}');
      }
      rethrow;
    }
  }

  Future<String> requestConsultingResult(int informationId) async {
    try {
      print('=== LLM 요청 디버깅 ===');
      print('Request URL: /v1/consultings/generate');
      print('Request Data: {information_id: $informationId}');
      
      final response = await dio.post(
        '/v1/consultings/generate',
        data: {'information_id': informationId},
        options: Options(
          receiveTimeout: const Duration(minutes: 2), // LLM 응답 대기 시간: 2분
          sendTimeout: const Duration(seconds: 30),   // 요청 전송 시간: 30초
        ),
      );
      
      print('LLM Response: ${response.data}');
      print('LLM Response type: ${response.data.runtimeType}');
      
      // 응답 구조 확인 및 컨설팅 결과 추출
      final responseData = response.data;
      String consultingResult;
      
      if (responseData is Map<String, dynamic>) {
        // 실제 응답 구조: {success: true, consulting_id: 2, data: {consulting_result: "..."}}
        if (responseData.containsKey('data') && 
            responseData['data'] is Map<String, dynamic> &&
            responseData['data']['consulting_result'] != null) {
          consultingResult = responseData['data']['consulting_result'] as String;
          print('data.consulting_result에서 컨설팅 결과 추출 성공');
        }
        // 다른 가능한 구조들도 지원
        else if (responseData.containsKey('data') && responseData['data']['recommendation'] != null) {
          consultingResult = responseData['data']['recommendation'] as String;
          print('data.recommendation에서 컨설팅 결과 추출 성공');
        } else if (responseData.containsKey('recommendation')) {
          consultingResult = responseData['recommendation'] as String;
          print('평면 recommendation에서 컨설팅 결과 추출 성공');
        } else if (responseData.containsKey('consulting_result')) {
          consultingResult = responseData['consulting_result'] as String;
          print('평면 consulting_result에서 컨설팅 결과 추출 성공');
        } else {
          print('응답 구조 분석:');
          print('- success: ${responseData['success']}');
          print('- consulting_id: ${responseData['consulting_id']}');
          print('- data keys: ${responseData['data']?.keys?.toList()}');
          throw Exception('응답에서 컨설팅 결과를 찾을 수 없습니다: $responseData');
        }
      } else {
        throw Exception('예상치 못한 응답 타입: ${responseData.runtimeType}');
      }
      
      return consultingResult;
    } catch (e) {
      print('LLM 요청 실패: $e');
      if (e is DioException) {
        print('LLM 응답 상태 코드: ${e.response?.statusCode}');
        print('LLM 응답 데이터: ${e.response?.data}');
      }
      throw Exception('LLM 요청 실패: $e');
    }
  }
}
