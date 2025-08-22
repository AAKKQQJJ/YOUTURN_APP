import 'package:dio/dio.dart';
import 'package:youturn/core/config/dio_client.dart';
import 'package:youturn/core/const/api_routes.dart';

class AuthApi {
  static Future<Response> login(String id, String pw) {
    return DioClient.dio.post(ApiRoutes.login, data: {
      'id': id,
      'password': pw,
    });
  }

  static Future<bool> signup(String nickname, String id, String password) async {
    final response = await DioClient.dio.post('/v1/auth/signup', data: {
      'nickname': nickname,
      'login_id': id,
      'password': password,
    });

    return response.statusCode == 201;
  }

  static Future<Response> autoLogin(String refreshToken) {
    return DioClient.dio.post(ApiRoutes.autoLogin, data: {
      'refreshToken': refreshToken,
    });
  }

  static Future<Response> logout(String accessToken) {
    return DioClient.dio.post(
      ApiRoutes.logout,
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
    );
  }
}
