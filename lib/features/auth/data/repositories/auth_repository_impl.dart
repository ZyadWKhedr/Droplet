import 'package:dartz/dartz.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/supabase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDataSource ds;
  AuthRepositoryImpl(this.ds);

  @override
  Future<Either<String, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await ds.signInWithEmail(email: email, password: password);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final user = await ds.signUpWithEmail(
          username: username, email: email, password: password);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> signInWithOAuth(SocialProvider provider) async {
    try {
      final user = await ds.signInWithOAuth(provider);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> signOut() => ds.signOut();

  @override
  Stream<UserEntity?> authStateChanges() => ds.authStateChanges();

  @override
  UserEntity? get currentUser => ds.currentUser;
}
