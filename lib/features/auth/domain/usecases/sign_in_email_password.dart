import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class SignInEmailPassword {
  final AuthRepository repo;
  SignInEmailPassword(this.repo);

  Future<Either<String, UserEntity>> call({
    required String email,
    required String password,
  }) => repo.signInWithEmail(email: email, password: password);
}
