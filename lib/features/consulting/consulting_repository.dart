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
      final response = await dio.post(
        '/v1/information',
        data: data.toJson(userId: usersId),
      );

      final infoId = response.data['data']['information_id'];
      return infoId; // LLM 요청 시에 이 ID 사용됨
    } catch (e) {
      print('정보 제출 실패: $e');
      rethrow;
    }
  }

  Future<String> requestConsultingResult(int informationId) async {
    try {
      final response = await dio.post(
        '/v1/consultings/generate',
        data: {'information_id': informationId},
      );
      return response.data['data']['recommendation'] as String;
    } catch (e) {
      throw Exception('LLM 요청 실패: $e');
    }
  }
}
