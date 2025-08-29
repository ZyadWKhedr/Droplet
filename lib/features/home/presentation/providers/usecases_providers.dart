import 'package:droplet/features/home/domain/usecases/get_latest_readings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:droplet/features/home/domain/usecases/watch_inserts.dart';
import 'package:droplet/features/home/domain/usecases/fetch_range.dart';
import 'package:droplet/features/home/domain/repositories/iot_repository.dart';

// First, expose the repository (implemented in data layer)
final iotRepositoryProvider = Provider<IotRepository>((ref) {
  throw UnimplementedError('Must override in main with IotRepositoryImpl');
});

// Use case providers
final watchInsertsProvider = Provider<WatchInserts>((ref) {
  final repo = ref.watch(iotRepositoryProvider);
  return WatchInserts(repo);
});

final fetchLatestProvider = Provider<FetchLatestUseCase>((ref) {
  final repo = ref.watch(iotRepositoryProvider);
  return FetchLatestUseCase(repo);
});

final fetchRangeProvider = Provider<FetchRangeUseCase>((ref) {
  final repo = ref.watch(iotRepositoryProvider);
  return FetchRangeUseCase(repo);
});
