import '../entities/recommendation_entity.dart';
import '../entities/sensor_data_entity.dart';
import '../repositories/ai_repository.dart';

class GetPlantRecommendationsUseCase {
  final AiRepository repo;
  GetPlantRecommendationsUseCase(this.repo);

  Future<List<Recommendation>> call(SensorData sensor) {
    return repo.getPlantRecommendations(sensor: sensor);
  }
}
