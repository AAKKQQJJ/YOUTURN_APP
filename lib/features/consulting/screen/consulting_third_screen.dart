import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/user_provider.dart';
import '../consulting_data.dart';
import '../consulting_repository.dart';
import 'consulting_result_screen.dart';

class ConsultingThirdScreen extends ConsumerStatefulWidget {
  final ConsultingData consultingData;

  const ConsultingThirdScreen({super.key, required this.consultingData});

  @override
  ConsumerState<ConsultingThirdScreen> createState() => _ConsultingThirdScreenState();
}

class _ConsultingThirdScreenState extends ConsumerState<ConsultingThirdScreen> {
  final TextEditingController etcController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final consultingRepository = ref.watch(consultingRepositoryProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'AI 귀농 컨설팅',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.lightGreen.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('추가 정보 입력', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TextField(
                        controller: etcController,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                            child: const Text('뒤로'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (user == null) {
                                      _showSnackbar("사용자 정보를 찾을 수 없습니다");
                                      return;
                                    }

                                    print('=== 사용자 정보 디버깅 ===');
                                    print('user: $user');
                                    print('user.id: ${user.id}');
                                    print('user.id 타입: ${user.id.runtimeType}');

                                    setState(() => isLoading = true);

                                    // 최종 데이터 구성 (기타 정보 추가)
                                    final finalData = widget.consultingData.copyWith(
                                      etc: etcController.text.trim(),
                                    );

                                    try {
                                      // 1단계: 컨설팅 정보 제출
                                      final informationId = await consultingRepository.submitConsultingInfo(
                                        usersId: user.id,
                                        data: finalData,
                                      );

                                      // 2단계: LLM 결과 요청
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('AI가 컨설팅 결과를 생성하고 있습니다... (최대 2분 소요)'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                      
                                      final llmResult = await consultingRepository.requestConsultingResult(informationId);

                                      if (!mounted) return;

                                      // 결과 화면으로 이동
                                      context.push(
                                        '/consulting_result',
                                        extra: llmResult,
                                      );
                                    } catch (e) {
                                      if (mounted) {
                                        _showSnackbar("컨설팅 요청 중 오류 발생: ${e.toString()}");
                                      }
                                    } finally {
                                      if (mounted) {
                                        setState(() => isLoading = false);
                                      }
                                    }
                                  },
                                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: isLoading 
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('컨설팅 시작'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Text('3 / 3'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
