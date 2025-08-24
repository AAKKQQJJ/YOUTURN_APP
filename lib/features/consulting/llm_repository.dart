import 'package:dio/dio.dart';

class LLMRepository {
  final Dio dio;

  LLMRepository(this.dio);

  Future<String> getLLMResult({required int informationId}) async {
    try {
      final response = await dio.post(
        '/v1/consultings/generate',
        data: {
          'information_id': informationId,
        },
      );

      return response.data['data']['recommendation'] as String;
    } catch (e) {
      throw Exception('LLM 요청 실패: $e');
    }
  }
}
