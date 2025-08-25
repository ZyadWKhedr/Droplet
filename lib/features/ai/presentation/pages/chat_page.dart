import 'package:droplet/features/ai/presentation/providers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/sensor_data_entity.dart';
import '../widgets/message_bubble.dart';
import '../widgets/recommendation_card.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _controller = TextEditingController();

  // For demo: fake sensor values (you will replace later with your real sensors)
  SensorData get _demoSensor =>
      const SensorData(temperatureC: 27.0, humidityPct: 62.0, rainfallMm: 0.0);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerProvider);
    final notifier = ref.read(chatControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat + Plant Recs'),
        actions: [
          IconButton(
            tooltip: 'Get two plant recommendations from current weather',
            onPressed: () => notifier.requestPlantRecommendations(_demoSensor),
            icon: const Icon(Icons.local_florist),
          ),
        ],
      ),
      body: Column(
        children: [
          if (state.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${state.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                ...state.messages.map((m) => MessageBubble(message: m)),
                if (state.recommendations.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'Recommended for your weather:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Exactly two cards (as requested)
                  ...state.recommendations.map(
                    (r) => RecommendationCard(rec: r),
                  ),
                ],
                if (state.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _send(notifier),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _send(notifier),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _send(ChatController notifier) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    notifier.sendUserMessage(
      text,
      sensor: _demoSensor,
    ); // include sensor data in chat if you want
  }
}
