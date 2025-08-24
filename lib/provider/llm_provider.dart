import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/consulting/llm_repository.dart';
import 'dio_provider.dart';

final llmRepositoryProvider = Provider<LLMRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return LLMRepository(dio);
});

final llmResultProvider = FutureProvider.family<String, int>((ref, informationId) async {
  final repository = ref.watch(llmRepositoryProvider);
  return repository.getLLMResult(informationId: informationId);
});
