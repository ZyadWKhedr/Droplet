import 'package:droplet/features/home/domain/entities/iot_readings.dart';

abstract class IotRepository {
  /// Stream new readings (INSERT events).
  /// These will come in every ~3s from Supabase.
  /// UI layer can throttle/filter using `significantlyDifferent`.
  Stream<IotReading> watchInserts();

  /// Fetch the latest N readings (for initial screen or chart backfill).
  Future<List<IotReading>> fetchLatest({int limit = 200});

  /// Fetch readings in a time window (e.g. for history page).
  Future<List<IotReading>> fetchRange({
    required DateTime from,
    required DateTime to,
    int limit = 2000,
  });
}
