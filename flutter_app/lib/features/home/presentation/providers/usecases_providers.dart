import 'package:droplet/features/home/data/datasource/remote_datasource.dart';
import 'package:droplet/features/home/data/repository/iot_repository_impl.dart';
import 'package:droplet/features/home/domain/usecases/get_latest_readings.dart';
import 'package:droplet/features/home/presentation/providers/readings_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:droplet/features/home/domain/usecases/watch_inserts.dart';
import 'package:droplet/features/home/domain/usecases/fetch_range.dart';
import 'package:droplet/features/home/domain/repositories/iot_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// DataSource provider (needs Supabase client)
final iotRemoteDataSourceProvider = Provider<IotRemoteDataSource>((ref) {
  return IotRemoteDataSource(Supabase.instance.client);
});

/// Repository provider (wraps data source)
final iotRepositoryProvider = Provider<IotRepository>((ref) {
  final remote = ref.watch(iotRemoteDataSourceProvider);
  return IotRepositoryImpl(remote);
});

/// Use case providers
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
final waterPercentProvider = Provider<double>((ref) {
  final reading = ref.watch(liveReadingProvider).asData?.value;
  if (reading == null) return 0.0;

  // Convert water level (0..2000) to 0.0 - 1.0
  const maxWaterLevel = 2000;
  return (reading.waterLevel / maxWaterLevel).clamp(0.0, 1.0);
});
