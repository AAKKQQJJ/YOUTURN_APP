import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:youturn/core/const/colors.dart';

class ConsultingResultScreen extends StatelessWidget {
  final String resultText;

  const ConsultingResultScreen({
    super.key,
    required this.resultText,
  });

  @override
  Widget build(BuildContext context) {
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
          
          // UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  
                  // 로고와 제목
                  Row(
                    children: [
                      Image.asset('asset/img/logo.png', height: 32),
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
                  
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                  
                  const Center(
                    child: Text(
                      'AI 귀농 컨설팅 결과',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 28),
                  
                  // 결과 표시 영역
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCF6E4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '컨설팅 결과',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0DC577),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // 결과 텍스트 (Markdown 렌더링)
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Markdown(
                                data: resultText,
                                selectable: true, // 텍스트 선택 가능
                                styleSheet: MarkdownStyleSheet(
                                  // 제목 스타일 (# ## ###)
                                  h1: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0DC577),
                                    height: 1.4,
                                  ),
                                  h2: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0DC577),
                                    height: 1.3,
                                  ),
                                  h3: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF333333),
                                    height: 1.3,
                                  ),
                                  // 본문 텍스트
                                  p: const TextStyle(
                                    fontSize: 14,
                                    height: 1.6,
                                    color: Colors.black87,
                                  ),
                                  // 리스트 스타일
                                  listBullet: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0DC577),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // 강조 텍스트
                                  strong: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0DC577),
                                  ),
                                  // 기본 텍스트 테마
                                  textAlign: WrapAlignment.start,
                                ),
                                padding: const EdgeInsets.all(16),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // 버튼들
                          Row(
                            children: [
                              // 홈으로 버튼
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // 홈 화면으로 이동 (모든 스택 제거)
                                    context.go('/home');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[400],
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text('홈으로'),
                                ),
                              ),
                              
                              const SizedBox(width: 12),
                              
                              // 다시 컨설팅 받기 버튼
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // 컨설팅 첫 화면으로 이동 (모든 스택 제거)
                                    context.go('/consulting');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0DC577),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text('다시 받기'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
