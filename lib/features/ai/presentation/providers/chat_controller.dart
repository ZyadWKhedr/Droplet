import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/recommendation_entity.dart';
import '../../domain/entities/sensor_data_entity.dart';
import '../../domain/usecases/send_chat_message_usecase.dart';
import '../../domain/usecases/get_plant_recommendations_usecase.dart';
import 'ai_providers.dart';

class ChatState {
  final List<ChatMessage> messages;
  final List<Recommendation> recommendations; // last generated 2 cards
  final bool isLoading;
  final String? error;

  ChatState({
    required this.messages,
    required this.recommendations,
    required this.isLoading,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    List<Recommendation>? recommendations,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      recommendations: recommendations ?? this.recommendations,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory ChatState.initial() => ChatState(
        messages: const [],
        recommendations: const [],
        isLoading: false,
      );
}

class ChatController extends StateNotifier<ChatState> {
  final SendChatMessageUseCase _sendChat;
  final GetPlantRecommendationsUseCase _getRecs;

  ChatController(this._sendChat, this._getRecs) : super(ChatState.initial());

  Future<void> sendUserMessage(String text, {SensorData? sensor}) async {
    final newHistory = [...state.messages, ChatMessage(role: ChatRole.user, text: text)];
    state = state.copyWith(messages: newHistory, isLoading: true, error: null);

    try {
      final botText = await _sendChat(history: newHistory, sensor: sensor);
      final updated = [...newHistory, ChatMessage(role: ChatRole.bot, text: botText)];
      state = state.copyWith(messages: updated, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> requestPlantRecommendations(SensorData sensor) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final recs = await _getRecs(sensor);
      state = state.copyWith(recommendations: recs, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearRecommendations() {
    state = state.copyWith(recommendations: const []);
  }
}

final chatControllerProvider =
    StateNotifierProvider<ChatController, ChatState>((ref) {
  return ChatController(
    ref.watch(sendChatUseCaseProvider),
    ref.watch(getRecsUseCaseProvider),
  );
});
