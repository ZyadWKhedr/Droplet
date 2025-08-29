// lib/features/iot/data/datasources/iot_remote_datasource.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/iot_reading_model.dart';

class IotRemoteDataSource {
  IotRemoteDataSource(this.client, {this.tableName = 'readings'});

  final SupabaseClient client;
  final String tableName;

  /// Stream INSERT events from Supabase Realtime
  Stream<IotReadingModel> watchInserts() {
    return client
        .from(tableName)
        .stream(primaryKey: ['id']) // MUST include primary key column(s)
        .order('time', ascending: false)
        .map(
          (rows) => rows.map(IotReadingModel.fromMap),
        ) // convert each row into model
        .expand((mappedList) => mappedList); // flatten list -> stream of models
  }

  /// Fetch latest rows
  Future<List<IotReadingModel>> fetchLatest({int limit = 200}) async {
    final rows = await client
        .from(tableName)
        .select()
        .order('time', ascending: false)
        .limit(limit);

    return (rows as List)
        .cast<Map<String, dynamic>>()
        .map(IotReadingModel.fromMap)
        .toList();
  }

  /// Fetch range of rows
  Future<List<IotReadingModel>> fetchRange({
    required DateTime from,
    required DateTime to,
    int limit = 2000,
  }) async {
    final rows = await client
        .from(tableName)
        .select()
        .gte('time', from.toUtc().toIso8601String())
        .lte('time', to.toUtc().toIso8601String())
        .order('time', ascending: true)
        .limit(limit);

    return (rows as List)
        .cast<Map<String, dynamic>>()
        .map(IotReadingModel.fromMap)
        .toList();
  }
}
