import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/user_provider.dart';
import '../consulting_data.dart';

class ConsultingSecondScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> consultingData;

  const ConsultingSecondScreen({super.key, required this.consultingData});

  @override
  ConsumerState<ConsultingSecondScreen> createState() => _ConsultingSecondScreenState();
}

class _ConsultingSecondScreenState extends ConsumerState<ConsultingSecondScreen> {
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _cropController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

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
                          color: Color(0xFF0DC577),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                  const Center(
                    child: Text(
                      '귀농 정보 입력',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 입력 박스
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCF6E4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _buildTextField(_budgetController, '예산 입력 (숫자만)'),
                        const SizedBox(height: 20),
                        _buildTextField(_cropController, '선호 작물 입력'),
                        const SizedBox(height: 20),
                        _buildTextField(_regionController, '선호 지역 입력'),
                        const SizedBox(height: 20),
                        _buildTextField(_experienceController, '농사 경험 입력'),
                        const SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () => _goToNextStep(context, ref),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0DC577),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('다음'),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text("2 / 3"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _goToNextStep(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    if (user == null) return;

    // 1. ConsultingData 인스턴스 생성
    final consultingData = ConsultingData(
      budget: _budgetController.text,
      preferredCrops: _cropController.text,
      preferredRegion: _regionController.text,
      farmingExperience: _experienceController.text,
      // 추가 필드가 있으면 여기에 작성
    );

    // 2. userId를 포함해 Map 형태로 변환
    final updatedData = consultingData.toJson(userId: user.id);

    // 3. GoRouter로 전달
    context.push(
      '/consulting_third',
      extra: updatedData,
    );
  }

  @override
  void dispose() {
    _budgetController.dispose();
    _cropController.dispose();
    _regionController.dispose();
    _experienceController.dispose();
    super.dispose();
  }
}
