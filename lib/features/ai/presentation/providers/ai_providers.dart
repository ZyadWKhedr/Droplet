import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../data/datasources/gemini_remote_datasource.dart';
import '../../data/repositories/ai_repository_impl.dart';
import '../../domain/repositories/ai_repository.dart';
import '../../domain/usecases/send_chat_message_usecase.dart';
import '../../domain/usecases/get_plant_recommendations_usecase.dart';

/// Use --dart-define=GEMINI_KEY=YOUR_KEY at run time
const _modelName = 'gemini-1.5-flash';

final geminiKeyProvider = Provider<String>((ref) {
  const String key = "AIzaSyC4jDgR7Mt-Nwuf3jvs5kzb62AMQTstNsc";
  if (key.isEmpty) {
    throw Exception(
      'GEMINI_KEY not provided. Use --dart-define=GEMINI_KEY=...',
    );
  }
  return key;
});

final geminiChatModelProvider = Provider<GenerativeModel>((ref) {
  final key = ref.watch(geminiKeyProvider);
  return GenerativeModel(model: _modelName, apiKey: key);
});

final geminiJsonModelProvider = Provider<GenerativeModel>((ref) {
  final key = ref.watch(geminiKeyProvider);
  return GenerativeModel(
    model: _modelName,
    apiKey: key,
    generationConfig: GenerationConfig(responseMimeType: 'application/json'),
  );
});

final remoteDataSourceProvider = Provider<GeminiRemoteDataSource>((ref) {
  return GeminiRemoteDataSource(
    chatModel: ref.watch(geminiChatModelProvider),
    jsonModel: ref.watch(geminiJsonModelProvider),
  );
});

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  return AiRepositoryImpl(ref.watch(remoteDataSourceProvider));
});

final sendChatUseCaseProvider = Provider<SendChatMessageUseCase>((ref) {
  return SendChatMessageUseCase(ref.watch(aiRepositoryProvider));
});

final getRecsUseCaseProvider = Provider<GetPlantRecommendationsUseCase>((ref) {
  return GetPlantRecommendationsUseCase(ref.watch(aiRepositoryProvider));
});
