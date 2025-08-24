import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/dio_provider.dart';
import '../../../provider/user_provider.dart';
import '../consulting_data.dart';
import '../consulting_repository.dart';

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
    final userId = user?.id;
    final dio = ref.watch(dioProvider);
    final consultingRepository = ConsultingRepository(dio);

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
                                    setState(() => isLoading = true);

                                    final updatedData = widget.consultingData.copyWith(
                                      etc: etcController.text,
                                    );

                                    try {
                                      final informationId =
                                          await consultingRepository.submitConsultingInfo(
                                              usersId: userId!, data: updatedData);
                                      final llmResult = await consultingRepository
                                          .requestConsultingResult(informationId);

                                      if (llmResult != null) {
                                        if (!mounted) return;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ConsultingResultScreen(resultText: llmResult),
                                          ),
                                        );
                                      } else {
                                        _showSnackbar("컨설팅 결과 요청 실패");
                                      }
                                    } catch (e) {
                                      _showSnackbar("컨설팅 요청 중 오류 발생");
                                    } finally {
                                      setState(() => isLoading = false);
                                    }
                                  },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: const Text('컨설팅 시작'),
                ₩          ),
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
