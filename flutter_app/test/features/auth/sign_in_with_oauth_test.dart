import 'package:droplet/features/auth/domain/entities/user_entity.dart';
import 'package:droplet/features/auth/domain/repositories/auth_repository.dart';
import 'package:droplet/features/auth/domain/usecases/sign_in_with_oauth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAuthRepo extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepo repo;
  late SignInWithOAuth usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignInWithOAuth(repo);
  });

  test('google oauth success', () async {
    final user = UserEntity(id: '1', email: 'g@x.com', name: 'GUser');
    when(
      () => repo.signInWithOAuth(SocialProvider.google),
    ).thenAnswer((_) async => Right(user));

    final res = await usecase(SocialProvider.google);
    expect(res.isRight(), true);
  });
}
