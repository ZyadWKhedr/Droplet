import 'package:droplet/features/home/data/datasource/remote_datasource.dart';
import 'package:droplet/features/home/domain/entities/iot_readings.dart';

import '../../domain/repositories/iot_repository.dart';

class IotRepositoryImpl implements IotRepository {
  IotRepositoryImpl(this._remote);

  final IotRemoteDataSource _remote;

  @override
  Stream<IotReading> watchInserts() => _remote.watchInserts();

  @override
  Future<List<IotReading>> fetchLatest({int limit = 200}) =>
      _remote.fetchLatest(limit: limit);

  @override
  Future<List<IotReading>> fetchRange({
    required DateTime from,
    required DateTime to,
    int limit = 2000,
  }) =>
      _remote.fetchRange(from: from, to: to, limit: limit);
}
