import '../../domain/entities/user_entity.dart';

sealed class AuthState {
  const AuthState();
}
class AuthUnknown extends AuthState { const AuthUnknown(); }
class AuthLoading extends AuthState { const AuthLoading(); }
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated(this.user);
}
class AuthUnauthenticated extends AuthState {
  final String? message;
  const AuthUnauthenticated([this.message]);
}
