class IotReading {
  final int id; // bigint
  final DateTime time; // timestamptz
  final double temperature; // real
  final double humidity; // real
  final int waterLevel; // int4
  final bool rainDetected; // bool
  final bool servoStatus; // bool

  const IotReading({
    required this.id,
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.waterLevel,
    required this.rainDetected,
    required this.servoStatus,
  });

  /// helper: check if two readings are meaningfully different
  /// Compares the current reading with the previous one
  /// For continuous valuesuse a threshold (delta)
  /// Example: ignore temp: 23.1 → 23.2 (tiny noise), but trigger update if it jumps 23.1 → 23.6.
  /// For booleans (rainDetected, servoStatus), any change matters, so we update immediately.
  bool significantlyDifferent(
    IotReading other, {
    double tempDelta = 0.3,
    double humidityDelta = 1.0,
    int waterLevelDelta = 2,
  }) {
    final tempChanged = (temperature - other.temperature).abs() >= tempDelta;
    final humidityChanged = (humidity - other.humidity).abs() >= humidityDelta;
    final waterChanged =
        (waterLevel - other.waterLevel).abs() >= waterLevelDelta;
    final rainChanged = rainDetected != other.rainDetected;
    final servoChanged = servoStatus != other.servoStatus;

    return tempChanged ||
        humidityChanged ||
        waterChanged ||
        rainChanged ||
        servoChanged;
  }
}
