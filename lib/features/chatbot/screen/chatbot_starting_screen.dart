import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/const/colors.dart';

class ChatbotStartingScreen extends StatelessWidget {
  const ChatbotStartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'asset/img/background.png',
              fit: BoxFit.cover, // 화면에 꽉 차게
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Image.asset(
                        'asset/img/logo.png',
                        height: 32,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '유턴',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'malang',
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'AI 귀농 챗봇',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // 버튼 1: 새로운 대화
                  _ChatOptionButton(
                    label: '새로운 대화',
                    backgroundColor: const Color(0xFF28C590),
                    textColor: Colors.white,
                    onTap: () => context.push('/chatbot'),
                  ),

                  const SizedBox(height: 40),

                  // 버튼 2: 이전 대화 이어하기
                  _ChatOptionButton(
                    label: '이전 대화 이어하기',
                    backgroundColor: const Color(0xFFB1F1D5),
                    textColor: Colors.black,
                    onTap: () {
                      // TODO: 이전 대화 연결
                    },
                  ),

                  const SizedBox(height: 40),

                  // 버튼 3: 자주 묻는 질문
                  _ChatOptionButton(
                    label: '자주 묻는 질문',
                    backgroundColor: const Color(0xFFB1F1D5),
                    textColor: Colors.black,
                    onTap: () {
                      // TODO: FAQ 이동
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatOptionButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const _ChatOptionButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.arrow_forward_ios, size: 18, color: textColor),
          ],
        ),
      ),
    );
  }
}
