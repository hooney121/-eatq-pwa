import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:eatq/config/theme.dart';  // 기존 import 유지 (theme.dart 파일 사용)
import 'package:eatq/features/common/views/splash_screen.dart';
import 'package:eatq/features/auth/views/login_screen.dart';
import 'package:eatq/features/auth/views/signup_screen.dart';
import 'package:eatq/features/auth/views/role_selection_screen.dart';
import 'package:eatq/features/customer/views/customer_home_screen.dart';
import 'package:eatq/features/store_owner/views/store_owner_home_screen.dart';

// routerProvider 정의
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,  // 디버깅을 위한 로그 활성화
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SignupScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/role-selection',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const RoleSelectionScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/customer',
        builder: (context, state) => const CustomerHomeScreen(),
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => const CustomerHomeScreen(),
          ),
          // 여기에 다른 고객 관련 경로 추가
          GoRoute(
            path: 'stores',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('매장 목록 화면')),
            ),
          ),
          GoRoute(
            path: 'orders',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('주문 내역 화면')),
            ),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('프로필 화면')),
            ),
          ),
          GoRoute(
            path: 'store/:id',
            builder: (context, state) {
              final storeId = state.pathParameters['id'] ?? '';
              return Scaffold(
                body: Center(child: Text('매장 상세: $storeId')),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/owner',
        builder: (context, state) => const StoreOwnerHomeScreen(),
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => const StoreOwnerHomeScreen(),
          ),
          // 여기에 다른 점주 관련 경로 추가
          GoRoute(
            path: 'stores',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('내 매장 관리 화면')),
            ),
          ),
          GoRoute(
            path: 'orders',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('주문 관리 화면')),
            ),
          ),
          GoRoute(
            path: 'store/:id',
            builder: (context, state) {
              final storeId = state.pathParameters['id'] ?? '';
              return Scaffold(
                body: Center(child: Text('매장 관리: $storeId')),
              );
            },
          ),
        ],
      ),
    ],
    // 오류 페이지 정의
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('페이지를 찾을 수 없습니다')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('경로를 찾을 수 없습니다: ${state.uri.path}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('홈으로 돌아가기'),
            ),
          ],
        ),
      ),
    ),
  );
});

class EatQApp extends ConsumerWidget {
  const EatQApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'EatQ',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,  // 라이트 테마로 고정 (원하는 경우 system으로 변경 가능)
      routerConfig: router,
      debugShowCheckedModeBanner: false,  // 우측 상단의 디버그 배너 제거
      scrollBehavior: const ScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),  // iOS 스타일 스크롤 물리 적용
      ),
    );
  }
}