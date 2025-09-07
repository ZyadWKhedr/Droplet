import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/recommendation_entity.dart';
import '../../domain/entities/sensor_data_entity.dart';
import '../../domain/repositories/ai_repository.dart';
import '../datasources/gemini_remote_datasource.dart';

class AiRepositoryImpl implements AiRepository {
  final GeminiRemoteDataSource remote;

  AiRepositoryImpl(this.remote);

  @override
  Future<String> sendChatMessage({
    required List<ChatMessage> history,
    SensorData? sensor,
  }) {
    return remote.sendChat(history: history, sensor: sensor);
  }

  @override
  Future<List<Recommendation>> getPlantRecommendations({
    required SensorData sensor,
  }) {
    return remote.getTwoRecommendations(sensor: sensor);
  }
}
