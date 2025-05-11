import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:eatq/core/services/supabase_service.dart';  // auth_service.dart 대신 supabase_service.dart 사용

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      print('로그인 시도: ${_emailController.text.trim()}');

      // 직접 Supabase 인스턴스 사용
      final supabase = Supabase.instance.client;
      final response = await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      print('로그인 응답: ${response.session != null ? '성공' : '실패'}');
      print('사용자 ID: ${response.user?.id}');

      if (response.session != null && mounted) {
        print('로그인 성공, 스플래시 화면으로 이동');
        // 로그인 성공 시 스플래시 화면으로 이동
        context.go('/');
      } else {
        setState(() {
          _errorMessage = '로그인에 실패했습니다. 이메일과 비밀번호를 확인해주세요.';
        });
      }
    } on AuthException catch (e) {
      print('인증 오류: $e');
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      print('기타 오류: $e');
      setState(() {
        _errorMessage = '로그인 중 오류가 발생했습니다. 다시 시도해주세요.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'EatQ',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: '이메일',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력해주세요';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return '유효한 이메일 주소를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: '비밀번호',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력해주세요';
                      }
                      if (value.length < 6) {
                        return '비밀번호는 최소 6자 이상이어야 합니다';
                      }
                      return null;
                    },
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signIn,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('로그인', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.push('/signup'),
                    child: const Text('계정이 없으신가요? 회원가입'),
                  ),
                  // 디버깅용 테스트 버튼 추가
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      print('테스트 로그인 시도');
                      try {
                        final supabase = Supabase.instance.client;
                        // 실제 존재하는 계정으로 변경하세요
                        final response = await supabase.auth.signInWithPassword(
                          email: 'hooney1218@gmail.com',  // 본인 계정으로 변경
                          password: '******',  // 본인 비밀번호로 변경 (실제 사용 시)
                        );
                        print('테스트 로그인 결과: ${response.session != null ? '성공' : '실패'}');

                        if (response.session != null && mounted) {
                          print('테스트 로그인 성공, 스플래시 화면으로 이동');
                          context.go('/');
                        }
                      } catch (e) {
                        print('테스트 로그인 오류: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('테스트 로그인'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}