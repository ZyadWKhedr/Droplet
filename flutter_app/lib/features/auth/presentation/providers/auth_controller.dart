import 'package:droplet/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:droplet/features/auth/data/models/profile_model.dart';
import 'package:droplet/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:droplet/features/auth/domain/repositories/auth_repository.dart';
import 'package:droplet/features/auth/domain/usecases/sign_in_email_password.dart';
import 'package:droplet/features/auth/domain/usecases/sign_in_with_oauth.dart';
import 'package:droplet/features/auth/domain/usecases/sign_out.dart';
import 'package:droplet/features/auth/domain/usecases/sign_up_email_password.dart';
import 'package:droplet/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, SupabaseClient;

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(supabaseProvider);
  return AuthRepositoryImpl(SupabaseAuthDataSource(client));
});

final authStateProvider = StateNotifierProvider<AuthController, AuthState>((
  ref,
) {
  return AuthController(ref);
});

class AuthController extends StateNotifier<AuthState> {
  final Ref _ref;

  AuthController(this._ref) : super(const AuthUnknown()) {
    _listen();
  }

  void _listen() {
    final repo = _ref.read(authRepositoryProvider);
    repo.authStateChanges().listen((user) async {
      if (user == null) {
        state = const AuthUnauthenticated();
      } else {
        state = AuthAuthenticated(user);

        await getUserProfile();
      }
    });
  }

  Future<void> signUpEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    state = const AuthLoading();
    final uc = SignUpEmailPassword(_ref.read(authRepositoryProvider));
    final res = await uc(username: username, email: email, password: password);
    res.fold((err) => state = AuthUnauthenticated(err), (user) async {
      state = AuthAuthenticated(user);
      final profile = await _ref.read(authRepositoryProvider).currentUser;
      if (profile != null) {
        state = AuthAuthenticated(profile);
      }
    });
  }

  Future<void> signInEmail({
    required String email,
    required String password,
  }) async {
    state = const AuthLoading();
    final uc = SignInEmailPassword(_ref.read(authRepositoryProvider));
    final res = await uc(email: email, password: password);
    res.fold((err) => state = AuthUnauthenticated(err), (user) async {
      state = AuthAuthenticated(user);
      await getUserProfile();
    });
  }

  Future<void> signInOAuth(SocialProvider provider) async {
    state = const AuthLoading();
    final uc = SignInWithOAuth(_ref.read(authRepositoryProvider));
    final res = await uc(provider);
    res.fold(
      (err) => state = AuthUnauthenticated(err),
      (user) => state = AuthAuthenticated(user),
    );
  }

  Future<void> signOut() async {
    final uc = SignOut(_ref.read(authRepositoryProvider));
    await uc();
    state = const AuthUnauthenticated();
  }

  Future<void> getUserProfile() async {
    final user = _ref.read(supabaseProvider).auth.currentUser;
    if (user == null) return;

    final response = await _ref
        .read(supabaseProvider)
        .from('profiles')
        .select('id, username, email')
        .eq('id', user.id)
        .maybeSingle();

    if (response != null) {
      final profile = ProfileModel.fromMap(response);
      state = AuthAuthenticated(profile);
    }
  }
}
