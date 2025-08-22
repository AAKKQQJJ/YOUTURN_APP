import 'package:youturn/core/config/dio_client.dart';

import '../../core/const/api_routes.dart';

class ChatbotApi {
  static Future<String> sendMessage(String message) async {
    final response = await DioClient.dio.post(
      ApiRoutes.chatbotMessage,
      data: {'message': message},
    );

    if (response.statusCode == 200) {
      return response.data['reply']; // 응답 형태에 따라 수정
    } else {
      throw Exception('챗봇 응답 실패: ${response.statusCode}');
    }
  }
}
