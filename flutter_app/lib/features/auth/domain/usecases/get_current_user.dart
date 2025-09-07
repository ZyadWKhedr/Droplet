import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class GetCurrentUser {
  final AuthRepository repo;
  GetCurrentUser(this.repo);

  Future<UserEntity?> call() => repo.currentUser;
}

