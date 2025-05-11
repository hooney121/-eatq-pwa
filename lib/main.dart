import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eatq/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load();

  // Supabase 초기화 코드 확인
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  print('Supabase URL: $supabaseUrl');
  print('Supabase Key 길이: ${supabaseAnonKey.length}');

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
    debug: true,
  );

  // 앱 실행
  runApp(const ProviderScope(child: EatQApp()));
}

// Supabase 클라이언트 인스턴스 가져오기
final supabase = Supabase.instance.client;