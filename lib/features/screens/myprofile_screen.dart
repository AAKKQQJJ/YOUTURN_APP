import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/const/colors.dart';
import '../../provider/user_provider.dart';

class MyprofileScreen extends ConsumerWidget {
  const MyprofileScreen({super.key});

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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
                  SizedBox(height: MediaQuery.of(context).size.width * 0.25),
                  // 프로필 이미지
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('asset/img/user_image.png'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${user?.nickname ?? "사용자"} 님',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 닉네임
                  const SizedBox(height: 28),
                  // 컨설팅 기록 박스
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        _buildRecordRow("컨설팅 요약", "25. 8. 1"),
                        SizedBox(height: 10),
                        const Divider(),
                        SizedBox(height: 8),
                        _buildRecordRow("컨설팅 요약", "25. 8. 2"),
                        SizedBox(height: 10),
                        const Divider(),
                        SizedBox(height: 8),
                        _buildRecordRow("컨설팅 요약", "25. 9. 2"),
                        SizedBox(height: 10),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // TODO - 더보기 동작
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          child: const Text('더보기'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordRow(String title, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Text(date, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
