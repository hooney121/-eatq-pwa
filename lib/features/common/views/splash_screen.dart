import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';  // 누락된 임포트
import 'package:eatq/core/services/supabase_service.dart';  // auth_service 대신 supabase_service 임포트

class SplashScreen extends ConsumerStatefulWidget {
const SplashScreen({super.key});

@override
ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
@override
void initState() {
super.initState();
_checkAuthState();
}

Future<void> _checkAuthState() async {
await Future.delayed(const Duration(seconds: 2));

try {
final supabase = Supabase.instance.client;
final session = supabase.auth.currentSession;

print('세션 확인: ${session != null ? '로그인됨' : '로그인되지 않음'}');

if (!mounted) return;

if (session != null) {
// 사용자 역할 확인
final service = ref.read(supabaseServiceProvider);  // Provider에서 서비스 가져오기
final role = await service.getUserRole();  // supabaseService 대신 service 사용
print('사용자 역할: $role');

if (role == 'customer') {
print('고객으로 홈 화면 이동');
context.go('/customer/home');
} else if (role == 'store_owner') {
print('점주로 홈 화면 이동');
context.go('/owner/home');
} else {
print('역할 선택 화면으로 이동');
context.go('/role-selection');
}
} else {
print('로그인 화면으로 이동');
context.go('/login');
}
} catch (e) {
print('인증 상태 확인 오류: $e');
if (!mounted) return;
context.go('/login');
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
// 로고 이미지 또는 아이콘
Icon(
Icons.restaurant,
size: 100,
color: Theme.of(context).primaryColor,
),
const SizedBox(height: 24),
const Text(
'EatQ',
style: TextStyle(
fontSize: 48,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 48),
const CircularProgressIndicator(),
],
),
),
);
}
}