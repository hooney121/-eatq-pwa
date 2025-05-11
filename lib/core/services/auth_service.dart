import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:eatq/core/services/supabase_service.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // 이메일 회원가입
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
      },
    );

    return response;
  }

  // 이메일 로그인
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return response;
  }

  // 로그아웃
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // 비밀번호 재설정 이메일 전송
  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  // 현재 인증 상태 스트림
  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;

  // 현재 로그인 상태 확인
  bool get isAuthenticated => supabase.auth.currentUser != null;

  // 사용자 역할 가져오기
  Future<String> getUserRole() async {
    if (!isAuthenticated) return 'guest';
    return await supabaseService.getUserRole();
  }
}

// Providers
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

final currentUserProvider = Provider<User?>((ref) {
  final authStateAsync = ref.watch(authStateProvider);
  return authStateAsync.value?.session?.user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

final userRoleProvider = FutureProvider<String>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getUserRole();
});