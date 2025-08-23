import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class SignUpEmailPassword {
  final AuthRepository repo;
  SignUpEmailPassword(this.repo);

  Future<Either<String, UserEntity>> call({
    required String username,
    required String email,
    required String password,
  }) => repo.signUpWithEmail(username: username, email: email, password: password);
}
