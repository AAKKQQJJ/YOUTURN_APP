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
      final response = await AuthApi.login(id, pw);
      if (response.statusCode == 200) {
        final userId = response.data['user']['user_id'];
        final accessToken = response.data['accessToken'];
        final nickname = response.data['user']['nickname'];

        // ✅ 유저 상태에 저장
        ref.read(userProvider.notifier).state =
            User(id: userId, nickname: nickname, accessToken: accessToken);

        if (!mounted) return;
        context.pushReplacement('/main');
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
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
              const Spacer(),
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
