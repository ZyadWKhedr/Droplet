import 'package:droplet/features/home/domain/entities/iot_readings.dart';
import 'package:droplet/features/home/presentation/providers/iot_notifiers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final liveReadingProvider =
    StreamNotifierProvider<LiveReadingNotifier, IotReading>(
      () => LiveReadingNotifier(),
    );

final latestReadingsProvider =
    AsyncNotifierProvider<LatestReadingsNotifier, List<IotReading>>(
      () => LatestReadingsNotifier(),
    );

final historyProvider =
    AsyncNotifierProvider<HistoryNotifier, List<IotReading>>(
      () => HistoryNotifier(),
    );

final selectedReadingProvider = StateProvider<IotReading?>((ref) => null);
