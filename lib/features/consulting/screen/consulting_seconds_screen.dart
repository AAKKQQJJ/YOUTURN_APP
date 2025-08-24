import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/user_provider.dart';
import '../consulting_data.dart';

class ConsultingSecondScreen extends ConsumerStatefulWidget {
  final ConsultingData consultingData;

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
                        _buildTextField(_budgetController, '예산 입력 (숫자만)', TextInputType.number),
                        const SizedBox(height: 20),
                        _buildTextField(_cropController, '선호 작물 입력'),
                        const SizedBox(height: 20),
                        _buildTextField(_regionController, '선호 지역 입력'),
                        const SizedBox(height: 20),
                        _buildTextField(_experienceController, '농사 경험 입력 (년수)', TextInputType.number),
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

  Widget _buildTextField(TextEditingController controller, String hint, [TextInputType? keyboardType]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
    // 입력 검증
    if (_budgetController.text.trim().isEmpty || 
        _cropController.text.trim().isEmpty ||
        _regionController.text.trim().isEmpty ||
        _experienceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 필드를 입력해주세요')),
      );
      return;
    }

    // 이전 단계 데이터와 현재 단계 데이터를 합치기
    final updatedData = widget.consultingData.copyWith(
      budget: _budgetController.text.trim(),
      preferredCrops: _cropController.text.trim(),
      preferredRegion: _regionController.text.trim(),
      farmingExperience: _experienceController.text.trim(),
    );

    // 세 번째 화면으로 이동
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
