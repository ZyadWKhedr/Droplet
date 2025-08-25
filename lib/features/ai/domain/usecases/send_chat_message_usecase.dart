import '../entities/chat_message_entity.dart';
import '../entities/sensor_data_entity.dart';
import '../repositories/ai_repository.dart';

class SendChatMessageUseCase {
  final AiRepository repo;
  SendChatMessageUseCase(this.repo);

  Future<String> call({
    required List<ChatMessage> history,
    SensorData? sensor,
  }) {
    return repo.sendChatMessage(history: history, sensor: sensor);
  }
}
