import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/const/colors.dart';
import '../../../provider/user_provider.dart';
import '../auth_api.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    final id = _idController.text.trim();
    final pw = _pwController.text.trim();

    if (id.isEmpty || pw.isEmpty) {
      _showMessage('아이디와 비밀번호를 입력해주세요.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      print('=== 로그인 요청 시작 ===');
      print('로그인 ID: $id');
      
      final response = await AuthApi.login(id, pw);
      
      print('=== 로그인 응답 ===');
      print('상태 코드: ${response.statusCode}');
      print('응답 데이터: ${response.data}');
      print('응답 타입: ${response.data.runtimeType}');
      
      if (response.statusCode == 200) {
        // 응답 구조 확인
        final responseData = response.data;
        
        if (responseData is Map<String, dynamic>) {
          print('응답 키들: ${responseData.keys.toList()}');
          
          // 다양한 응답 구조 지원
          int? userId;
          String? accessToken;
          String? nickname;
          
          // userId 추출
          if (responseData.containsKey('user') && responseData['user'] is Map) {
            userId = responseData['user']['user_id'];
            nickname = responseData['user']['nickname'];
          } else if (responseData.containsKey('user_id')) {
            userId = responseData['user_id'];
          }
          
          // accessToken 추출
          if (responseData.containsKey('accessToken')) {
            accessToken = responseData['accessToken'];
          } else if (responseData.containsKey('access_token')) {
            accessToken = responseData['access_token'];
          } else if (responseData.containsKey('token')) {
            accessToken = responseData['token'];
          }
          
          // nickname 추출 (user 객체에 없는 경우)
          if (nickname == null && responseData.containsKey('nickname')) {
            nickname = responseData['nickname'];
          }
          
          print('추출된 정보:');
          print('- userId: $userId');
          print('- nickname: $nickname');
          print('- accessToken: ${accessToken != null ? "존재함 (${accessToken.length}자)" : "없음"}');
          
          if (userId != null && accessToken != null && nickname != null) {
            // ✅ 유저 상태에 저장
            ref.read(userProvider.notifier).state =
                User(id: userId, nickname: nickname, accessToken: accessToken);

            if (!mounted) return;
            context.pushReplacement('/main');
          } else {
            _showMessage('로그인 응답에서 필요한 정보를 찾을 수 없습니다.');
          }
        } else {
          _showMessage('예상치 못한 응답 형식입니다.');
        }
      } else {
        _showMessage('로그인에 실패했습니다.');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _showMessage('아이디 또는 비밀번호가 올바르지 않습니다.');
      } else {
        _showMessage('서버 오류가 발생했습니다. (${e.response?.statusCode})');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면 크기 조정
      body: SafeArea(
        child: SingleChildScrollView( // 스크롤 가능하게 만들기
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                  MediaQuery.of(context).padding.top - 
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    '귀농을 꿈꾸는 당신을 위한 AI 멘토',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'suit',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('asset/img/logo.png', height: 54, width: 66),
                      const Text(
                        '유턴',
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'malang',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('아이디', style: _labelStyle),
                  ),
                  const SizedBox(height: 8),
                  _inputField(controller: _idController, obscure: false),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('비밀번호', style: _labelStyle),
                  ),
                  const SizedBox(height: 8),
                  _inputField(controller: _pwController, obscure: true),
                  const Expanded(child: SizedBox()), // Spacer 대신 Expanded 사용
                  _actionButton('로그인', _login),
                  const SizedBox(height: 12),
                  _actionButton('회원가입', () => context.push('/signup')),
                  const SizedBox(height: 12),
                  const Text(
                    '서비스 이용약관 및 개인정보 수집 이용',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({required TextEditingController controller, required bool obscure}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }

  Widget _actionButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: _isLoading ? null : onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF0DB2B2),
            fontSize: 20,
            fontFamily: 'malang',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  static const _labelStyle = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontFamily: 'malang',
    fontWeight: FontWeight.w700,
  );
}
