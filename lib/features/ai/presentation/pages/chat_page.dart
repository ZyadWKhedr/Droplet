import 'package:droplet/core/constatnts/app_images.dart';
import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:droplet/features/ai/presentation/providers/chat_controller.dart';
import 'package:droplet/features/ai/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/sensor_data_entity.dart';
import '../widgets/message_bubble.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  // For demo: fake sensor values (you will replace later with your real sensors)
  SensorData get _demoSensor =>
      const SensorData(temperatureC: 27.0, humidityPct: 62.0, rainfallMm: 0.0);

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerProvider);
    final notifier = ref.read(chatControllerProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Column(
              children: [
                SizedBox(height: 70.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.chatbot, width: 48.w, height: 48.h),
                    SizedBox(width: 16.w),
                    Text('Chatbot', style: AppText.h2),
                  ],
                ),
                SizedBox(height: 10.h),
                Divider(color: Color(0xff9FA6B3)),
              ],
            ),
          ),
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
              controller: _scrollController, // attach controller
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                ...state.messages.map((m) => MessageBubble(message: m)),
                if (state.isLoading)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Stack(
                    children: [
                      CustomTextField(
                        controller: _controller,
                        hint: context.loc.botInput,
                        onSubmitted: (_) => _send(notifier),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: IconButton(
                          onPressed: () => _send(notifier),
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
