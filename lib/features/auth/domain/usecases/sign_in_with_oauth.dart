import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class SignInWithOAuth {
  final AuthRepository repo;
  SignInWithOAuth(this.repo);

  Future<Either<String, UserEntity>> call(SocialProvider provider) =>
      repo.signInWithOAuth(provider);
}
