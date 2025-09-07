import 'package:droplet/features/home/presentation/providers/usecases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:droplet/features/home/domain/entities/iot_readings.dart';

/// 1. Live stream of latest inserts
class LiveReadingNotifier extends StreamNotifier<IotReading> {
  @override
  Stream<IotReading> build() {
    final watchInserts = ref.watch(watchInsertsProvider);
    return watchInserts(); 
  }
}

/// 2. Latest batch (for initial screen / chart backfill)
class LatestReadingsNotifier extends AsyncNotifier<List<IotReading>> {
  @override
  Future<List<IotReading>> build() async {
    final fetchLatest = ref.watch(fetchLatestProvider);
    return fetchLatest(limit: 200);
  }
}

/// 3. History (time range)
class HistoryNotifier extends AsyncNotifier<List<IotReading>> {
  @override
  Future<List<IotReading>> build() async {
    // empty by default (user selects a range later)
    return [];
  }

  Future<void> fetch(DateTime from, DateTime to) async {
    state = const AsyncLoading();
    final fetchRange = ref.read(fetchRangeProvider);
    state = await AsyncValue.guard(() => fetchRange(from: from, to: to));
  }
}
