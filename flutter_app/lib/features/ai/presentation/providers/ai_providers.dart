import 'package:droplet/features/ai/domain/entities/recommendation_entity.dart';
import 'package:droplet/features/ai/domain/entities/sensor_data_entity.dart';
import 'package:droplet/features/home/domain/entities/iot_readings.dart';
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
  const String key = "AIzaSyBhB0ISbASnLSx5JxiI5SqcP2EX4OONhf0";
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
final plantRecommendationsProvider = FutureProvider.autoDispose
    .family<List<Recommendation>, IotReading>((ref, reading) async {
      final sensor = SensorData(
        temperatureC: reading.temperature,
        humidityPct: reading.humidity,
        rainfallMm: reading.rainDetected ? 1.0 : 0.0,
      );

      final useCase = GetPlantRecommendationsUseCase(
        ref.watch(aiRepositoryProvider),
      );
      final recs = await useCase.call(sensor);
      return recs.take(2).toList();
    });
