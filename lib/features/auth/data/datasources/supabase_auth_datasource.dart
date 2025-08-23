import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class SupabaseAuthDataSource {
  final SupabaseClient client;
  SupabaseAuthDataSource(this.client);

  Future<UserModel> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    final res = await client.auth.signUp(
      email: email,
      password: password,
      data: {'name': username},
    );
    final user = res.user;
    if (user == null) throw AuthException('No user returned');
    return UserModel.fromSupabase(user.toJson());
  }

  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final res = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = res.user;
    if (user == null) throw AuthException('No user returned');
    return UserModel.fromSupabase(user.toJson());
  }

  Future<UserModel> signInWithOAuth(SocialProvider provider) async {
    final sp = switch (provider) {
      SocialProvider.google => OAuthProvider.google,
      SocialProvider.apple => OAuthProvider.apple,
      SocialProvider.facebook => OAuthProvider.facebook,
    };

    // Hosted OAuth flow (mobile/web). Requires URL scheme deep link config.
    final res = await client.auth.signInWithOAuth(
      sp,
      redirectTo: null, // Supabase Flutter handles mobile deep links via scheme
      queryParams: {'prompt': 'select_account'}, // optional
    );

    // After redirect, Supabase restores session automatically.
    // Return current user when available.
    final sub = client.auth.onAuthStateChange;
    final c = Completer<UserModel>();
    final s = sub.listen((event) {
      final user = event.session?.user;
      if (user != null && !c.isCompleted) {
        c.complete(UserModel.fromSupabase(user.toJson()));
      }
    });
    final user = await c.future.timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        s.cancel();
        throw AuthException('OAuth timed out');
      },
    );
    await s.cancel();
    return user;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  Stream<UserModel?> authStateChanges() async* {
    yield client.auth.currentUser != null
        ? UserModel.fromSupabase(client.auth.currentUser!.toJson())
        : null;

    yield* client.auth.onAuthStateChange.map((e) {
      final u = e.session?.user;
      return u == null ? null : UserModel.fromSupabase(u.toJson());
    });
  }

  UserModel? get currentUser {
    final u = client.auth.currentUser;
    return u == null ? null : UserModel.fromSupabase(u.toJson());
  }
}
