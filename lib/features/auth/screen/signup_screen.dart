import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/const/colors.dart';
import '../auth_api.dart'; // primaryColor 등

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nicknameController = TextEditingController();

  final TextEditingController idController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
              const SizedBox(height: 24),
              // 뒤로가기 버튼
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    context.pop(); // go_router 기준
                  },
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '귀농을 꿈꾸는 당신을 위한 AI 멘토',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'suit',
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/img/logo.png',
                    height: 54,
                    width: 66,
                  ),
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
              const SizedBox(height: 40),

              // 닉네임
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '닉네임',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'malang',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: TextField(
                  controller: nicknameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 아이디
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '아이디',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'malang',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 비밀번호
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '비밀번호',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'malang',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),

              const Expanded(child: SizedBox()), // Spacer 대신 Expanded 사용

              // 회원가입 버튼
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () async {
                    final nickname = nicknameController.text.trim();
                    final id = idController.text.trim();
                    final pw = passwordController.text.trim();

                    if (nickname.isEmpty || id.isEmpty || pw.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('모든 항목을 입력해주세요.')),
                      );
                      return;
                    }

                    try {
                      final success = await AuthApi.signup(nickname, id, pw);

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('회원가입이 완료되었습니다.')),
                        );
                        context.go('/login'); // 또는 context.pop() 으로 로그인 화면 복귀
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('회원가입에 실패했습니다.')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('에러 발생: $e')),
                      );
                    }
                  },
                  child: const Text(
                    '회원가입',
                    style: TextStyle(
                      color: Color(0xFF0DB2B2),
                      fontSize: 20,
                      fontFamily: 'malang',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '서비스 이용약관 및 개인정보 수집 이용',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                ),
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
}
