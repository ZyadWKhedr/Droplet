import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/sensor_data_entity.dart';
import '../../domain/entities/recommendation_entity.dart';

class GeminiRemoteDataSource {
  final GenerativeModel chatModel;
  final GenerativeModel jsonModel; // for structured recommendations

  GeminiRemoteDataSource({required this.chatModel, required this.jsonModel});

  // Builds a system-style instruction
  String _systemPrompt() => '''
You are a dedicated AI horticulture and gardening assistant. Your only function is to provide advice and information related to plants, gardening, and agriculture.

Your core directives are:

- Scope: You must only respond to queries directly about plants, gardening practices, soil health, pest management, and related agricultural topics. You must politely decline to answer any questions outside this scope.
- Greetings: You will acknowledge simple greetings like "Hello," "Good morning," and "Good night" with a friendly, plant-themed response before inviting a gardening question.
- Data-Driven Advice: If a user provides sensor data (e.g., temperature °C, humidity %, rainfall mm) and/or a location, you must use this information to tailor your advice specifically to those conditions.
- Conciseness: Keep all responses helpful and to the point.
- Sources: If explicitly asked for links or further reading, you may only recommend reputable sources such as university extensions (.edu), government agricultural departments (.gov), or established gardening organizations (.org).

Format: Your responses must be text-only. Do not generate or mention images, code, or base64 strings.
''';

  // Convert app history to Gemini Contents
  List<Content> _toContents(List<ChatMessage> history, {SensorData? sensor}) {
    final systemPrompt = _systemPrompt();

    // prepend as first "user" message
    final systemAsUser = Content.text(systemPrompt);

    final msgs = history.map((m) {
      return m.role == ChatRole.user
          ? Content.text(m.text)
          : Content.model([TextPart(m.text)]);
    }).toList();

    final extra = sensor == null
        ? <Content>[]
        : [
            Content.text(
              'Sensor data — temperature: ${sensor.temperatureC} °C, '
              'humidity: ${sensor.humidityPct} %, rainfall: ${sensor.rainfallMm} mm',
            ),
          ];

    return [systemAsUser, ...msgs, ...extra];
  }

  Future<String> sendChat({
    required List<ChatMessage> history,
    SensorData? sensor,
  }) async {
    final contents = _toContents(history, sensor: sensor);
    final resp = await chatModel.generateContent(contents);
    return resp.text ?? 'Sorry, I could not generate a response.';
  }

  /// Ask Gemini to return EXACTLY two recommendations in strict JSON.
  Future<List<Recommendation>> getTwoRecommendations({
    required SensorData sensor,
  }) async {
    final instruction =
        '''
Create exactly TWO plant recommendations suitable for the CURRENT conditions:
- temperature (°C): ${sensor.temperatureC}
- humidity (%): ${sensor.humidityPct}
- rainfall (mm last 24h): ${sensor.rainfallMm}

Return STRICT JSON ONLY with this shape:

{
  "recommendations": [
    {
      "title": "Short catchy title",
      "plants": ["Plant A", "Plant B", "Plant C"],
      "article_url": "https://example.com/article"
    },
    {
      "title": "Another title",
      "plants": ["Plant X", "Plant Y"],
      "article_url": "https://example.com/article2"
    }
  ]
}

Rules:
- Exactly 2 items.
- article_url must be a valid absolute https URL.
- No markdown, no extra text, JSON only.
''';

    final resp = await jsonModel.generateContent([
      Content.text('You output machine-readable JSON for mobile apps.'),
      Content.text(instruction),
    ]);

    final raw = resp.text ?? '{}';
    final map = json.decode(raw) as Map<String, dynamic>;
    final list = (map['recommendations'] as List<dynamic>? ?? []);

    return list.take(2).map((e) {
      final m = e as Map<String, dynamic>;
      final url =
          Uri.tryParse('${m['article_url']}') ??
          Uri.parse('https://www.gardeningknowhow.com/');
      final plants = (m['plants'] as List<dynamic>? ?? [])
          .map((p) => '$p')
          .toList();
      return Recommendation(
        title: '${m['title'] ?? 'Recommendations'}',
        plants: plants,
        articleUrl: url,
      );
    }).toList();
  }
}
