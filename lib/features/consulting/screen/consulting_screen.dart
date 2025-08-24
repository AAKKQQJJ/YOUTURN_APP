import 'package:flutter/material.dart';
import 'package:youturn/core/const/colors.dart';

class ConsultingScreen extends StatefulWidget {
  const ConsultingScreen({super.key});

  @override
  State<ConsultingScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<ConsultingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 📌 1. 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'asset/img/background.png',
              fit: BoxFit.cover, // 화면에 꽉 차게
            ),
          ),

          // 📌 2. 위에 얹을 UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
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
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'AI 귀농 컨설팅',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  // 📦 사전 정보 입력 폼 박스
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Color(0xFFCCF6E4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _buildTextField('나이 입력'),
                          const SizedBox(height: 20),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: ElevatedButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             _selectedGender = '남';
                          //           });
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //           backgroundColor:
                          //               _selectedGender == '남' ? Colors.green : Colors.grey[300],
                          //           foregroundColor:
                          //               _selectedGender == '남' ? Colors.white : Colors.black,
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12),
                          //           ),
                          //         ),
                          //         child: const Text('남'),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 16),
                          //     Expanded(
                          //       child: ElevatedButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             _selectedGender = '여';
                          //           });
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //           backgroundColor:
                          //               _selectedGender == '여' ? Colors.green : Colors.grey[300],
                          //           foregroundColor:
                          //               _selectedGender == '여' ? Colors.white : Colors.black,
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12),
                          //           ),
                          //         ),
                          //         child: const Text('여'),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 20),
                          _buildTextField('주소 입력 (예: 전라남도 순천시)'),
                          const SizedBox(height: 20),
                          _buildTextField('가족 구성원 입력'),
                          const SizedBox(height: 20),
                          _buildTextField('직업 입력'),
                          const SizedBox(height: 28),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0DC577),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
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
}
