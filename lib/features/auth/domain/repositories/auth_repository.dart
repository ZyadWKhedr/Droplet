import 'package:dartz/dartz.dart';
import 'package:droplet/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<String, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Either<String, UserEntity>> signInWithOAuth(SocialProvider provider);

  Future<void> signOut();

  Stream<UserEntity?> authStateChanges();

  Future<UserEntity?> get currentUser;
}

enum SocialProvider { google, apple, facebook }
