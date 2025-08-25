import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youturn/core/const/colors.dart';

import '../consulting_data.dart';

class ConsultingScreen extends StatefulWidget {
  const ConsultingScreen({super.key});

  @override
  State<ConsultingScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<ConsultingScreen> {
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController familyController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  void dispose() {
    birthDateController.dispose();
    addressController.dispose();
    familyController.dispose();
    jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면 크기 조정
      body: Stack(
        children: [
          // 배경
          Positioned.fill(
            child: Image.asset(
              'asset/img/background.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // 사과 이미지들 (고정 위치)
          Positioned(
            top: 150,
            left: 15,
            child: Image.asset(
              'asset/img/Apple.png',
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            bottom: 200,
            right: 18,
            child: Image.asset(
              'asset/img/Apple.png',
              width: 50,
              height: 50,
            ),
          ),

          // 스크롤 가능한 UI
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 
                      MediaQuery.of(context).padding.top - 
                      MediaQuery.of(context).padding.bottom,
                ),
                child: IntrinsicHeight(
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
                          _buildDateField(),
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
                  const Expanded(child: SizedBox()), // Spacer 대신 Expanded 사용
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text("1 / 3"),
                  ),
                    ],
                  ),
                ),
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

  Widget _buildDateField() {
    return TextField(
      controller: birthDateController,
      readOnly: true,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime(1990),
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
            birthDateController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
          });
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        hintText: '생년월일 선택 (예: 1990-01-01)',
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        suffixIcon: const Icon(Icons.calendar_today),
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
    // 입력 검증
    if (_selectedDate == null ||
        _selectedGender == null ||
        addressController.text.trim().isEmpty ||
        familyController.text.trim().isEmpty ||
        jobController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 필드를 입력해주세요')),
      );
      return;
    }

    // ConsultingData 객체 생성 (첫 번째 단계 데이터)
    final consultingData = ConsultingData(
      birthDate: _selectedDate,
      gender: _selectedGender,
      address: addressController.text.trim(),
      familyMember: familyController.text.trim(),
      occupation: jobController.text.trim(),
    );

    // 두 번째 화면으로 이동
    context.push(
      '/consulting_seconds',
      extra: consultingData,
    );
  }
}
