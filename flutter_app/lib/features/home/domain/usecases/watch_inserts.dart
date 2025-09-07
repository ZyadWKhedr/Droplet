import 'package:droplet/features/home/domain/entities/iot_readings.dart';
import 'package:droplet/features/home/domain/repositories/iot_repository.dart';

class WatchInserts {
  final IotRepository repository;

  WatchInserts(this.repository);

  /// Returns a stream of the latest IoT readings
  Stream<IotReading> call() {
    return repository.watchInserts();
  }
}
