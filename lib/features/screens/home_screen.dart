import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/const/colors.dart';
import '../../provider/user_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'asset/img/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // 메인 컨텐츠
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // 상단 로고
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
                  const SizedBox(height: 40),
                  // 인사말
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '안녕하세요, ${user?.nickname ?? 'OOO'}님',
                          style: const TextStyle(
                            fontSize: 19,
                            fontFamily: 'suit',
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '귀농 준비, 이제 혼자가 아니에요',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black87,
                                  fontFamily: 'suit',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 4),
                            Text('🌱', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  // AI 귀농 컨설팅 카드
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),

                        const Text(
                          'AI 귀농 컨설팅',
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: 'suit',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 컨설팅 시작 버튼
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/consulting');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF4CAF50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '컨설팅 시작',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF04C372),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: Color(0xFF04C372),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 하단 버튼들
                  Row(
                    children: [
                      // 컨설팅 기록 바로가기
                      Expanded(
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCF6E4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                // TODO: 컨설팅 기록 페이지로 이동
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('컨설팅 기록 기능 준비 중입니다.'),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '컨설팅 기록',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF09AD68),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      '바로가기',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // AI 귀농 챗봇 대화하기
                      Expanded(
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCF6E4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                context.push('/chatbot');
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'AI 귀농 챗봇',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF09AD68),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      '대화하기',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 15,
            child: Image.asset(
              'asset/img/Apple.png',
              width: 50,
              height: 50,
            ),
          ),
          // 우측 하단 사과
          Positioned(
            bottom: 315,
            right: 40,
            child: Image.asset(
              'asset/img/Apple.png',
              width: 45,
              height: 45,
            ),
          ),
        ],
      ),
    );
  }
}
