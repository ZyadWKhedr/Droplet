// lib/features/iot/data/models/iot_reading_model.dart

import 'package:droplet/features/home/domain/entities/iot_readings.dart';

class IotReadingModel extends IotReading {
  const IotReadingModel({
    required super.id,
    required super.time,
    required super.temperature,
    required super.humidity,
    required super.waterLevel,
    required super.rainDetected,
    required super.servoStatus,
  });

  /// Factory constructor to parse a row from Supabase
  factory IotReadingModel.fromMap(Map<String, dynamic> map) {
    return IotReadingModel(
      id: (map['id'] as num).toInt(),
      time: DateTime.parse(map['time'] as String),
      temperature: (map['temperature'] as num).toDouble(),
      humidity: (map['humidity'] as num).toDouble(),
      waterLevel: (map['water_level'] as num).toInt(),
      rainDetected: map['rain_detected'] as bool,
      servoStatus: map['servo_status'] as bool,
    );
  }
}
