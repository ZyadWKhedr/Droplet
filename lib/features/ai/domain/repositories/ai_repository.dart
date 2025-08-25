import '../entities/chat_message_entity.dart';
import '../entities/sensor_data_entity.dart';
import '../entities/recommendation_entity.dart';

abstract class AiRepository {
  Future<String> sendChatMessage({
    required List<ChatMessage> history,
    SensorData? sensor,
  });

  Future<List<Recommendation>> getPlantRecommendations({
    required SensorData sensor,
  });
}
