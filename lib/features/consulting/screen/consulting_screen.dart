import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youturn/core/const/colors.dart';

class ConsultingScreen extends StatefulWidget {
  const ConsultingScreen({super.key});

  @override
  State<ConsultingScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<ConsultingScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController familyController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  String? _selectedGender;

  @override
  void dispose() {
    ageController.dispose();
    addressController.dispose();
    familyController.dispose();
    jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경
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
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                  const Center(
                    child: Text(
                      'AI 귀농 컨설팅',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 입력 폼
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCF6E4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _buildTextField('나이 입력', ageController),
                          const SizedBox(height: 20),

                          // 성별 선택
                          Row(
                            children: [
                              _buildGenderButton('남'),
                              const SizedBox(width: 16),
                              _buildGenderButton('여'),
                            ],
                          ),
                          const SizedBox(height: 20),

                          _buildTextField('주소 입력 (예: 전라남도 순천시)', addressController),
                          const SizedBox(height: 20),
                          _buildTextField('가족 구성원 입력', familyController),
                          const SizedBox(height: 20),
                          _buildTextField('직업 입력', jobController),
                          const SizedBox(height: 28),

                          ElevatedButton(
                            onPressed: _onNextPressed,
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
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text("1 / 3"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
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

  Widget _buildGenderButton(String gender) {
    final isSelected = _selectedGender == gender;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedGender = gender;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFF0DC577) : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(gender),
      ),
    );
  }

  void _onNextPressed() {
    // ✅ 상태 저장
    final consultingData = {
      'age': ageController.text.trim(),
      'gender': _selectedGender,
      'address': addressController.text.trim(),
      'family': familyController.text.trim(),
      'job': jobController.text.trim(),
    };

    // ✅ 페이지 이동 (명명된 라우트 사용)
    context.push(
      '/consulting_seconds',
      extra: consultingData,
    );
  }
}
