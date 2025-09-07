import 'package:droplet/features/home/domain/entities/iot_readings.dart';
import 'package:droplet/features/home/domain/repositories/iot_repository.dart';

class FetchRangeUseCase {
  final IotRepository repo;

  FetchRangeUseCase(this.repo);

  /// Fetch readings in a time window.
  Future<List<IotReading>> call({
    required DateTime from,
    required DateTime to,
    int limit = 2000,
  }) {
    return repo.fetchRange(from: from, to: to, limit: limit);
  }
}
