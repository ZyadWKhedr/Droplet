import 'package:droplet/features/auth/domain/entities/user_entity.dart';
import 'package:droplet/features/auth/domain/repositories/auth_repository.dart';
import 'package:droplet/features/auth/domain/usecases/sign_in_email_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAuthRepo extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepo repo;
  late SignInEmailPassword usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignInEmailPassword(repo);
  });

  test('returns UserEntity when success', () async {
    final user = UserEntity(id: '1', email: 'a@b.com', name: 'Zyad');
    when(
      () => repo.signInWithEmail(email: 'a@b.com', password: '123456'),
    ).thenAnswer((_) async => Right(user));

    final res = await usecase(email: 'a@b.com', password: '123456');

    expect(res.isRight(), true);
    expect(res.getOrElse(() => throw 'err').id, '1');
  });

  test('returns error string when failure', () async {
    when(
      () => repo.signInWithEmail(email: 'bad', password: 'x'),
    ).thenAnswer((_) async => const Left('Invalid credentials'));

    final res = await usecase(email: 'bad', password: 'x');
    expect(res.isLeft(), true);
  });
}
