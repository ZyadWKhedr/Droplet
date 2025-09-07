import 'package:droplet/features/home/domain/entities/iot_readings.dart';
import 'package:droplet/features/home/domain/repositories/iot_repository.dart';

class FetchLatestUseCase {
  final IotRepository repo;

  FetchLatestUseCase(this.repo);

  /// Fetch the latest N readings.
  Future<List<IotReading>> call({int limit = 200}) {
    return repo.fetchLatest(limit: limit);
  }
}
