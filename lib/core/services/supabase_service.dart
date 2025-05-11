import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // 현재 사용자 ID 가져오기
  String? get currentUserId => supabase.auth.currentUser?.id;

  // 현재 사용자 정보 가져오기
  User? get currentUser => supabase.auth.currentUser;

  // 사용자 역할 가져오기
  Future<String> getUserRole() async {
    try {
      final userId = currentUserId;
      if (userId == null) return 'guest';

      print('로그 확인: userId = $userId');

      final response = await supabase
          .from('user_roles')
          .select('role')
          .eq('user_id', userId)  // userId 사용
          .maybeSingle();

      print('로그 확인: 역할 조회 결과 = $response');

      if (response == null) {
        // 역할이 없는 경우 역할 생성
        print('로그 확인: 역할이 없어 새로 생성합니다');
        await supabase.from('user_roles').insert({
          'user_id': userId,  // userId 사용
          'role': 'customer'
        });
        return 'customer';
      }

      return response['role'] as String;
    } catch (e) {
      print('getUserRole 오류: $e');
      return 'customer';
    }
  }

  // 고객 정보 가져오기
  Future<Map<String, dynamic>?> getCustomerProfile() async {
    try {
      final userId = currentUserId;
      if (userId == null) return null;

      final response = await supabase
          .from('customers')
          .select()
          .eq('user_id', userId)  // userId 사용
          .maybeSingle();

      return response;
    } catch (e) {
      print('getCustomerProfile 오류: $e');
      return null;
    }
  }

  // 점주 정보 가져오기
  Future<Map<String, dynamic>?> getStoreOwnerProfile() async {
    try {
      final userId = currentUserId;
      if (userId == null) return null;

      final response = await supabase
          .from('store_owners')
          .select()
          .eq('user_id', userId)  // userId 사용
          .maybeSingle();

      return response;
    } catch (e) {
      print('getStoreOwnerProfile 오류: $e');
      return null;
    }
  }

  // 역할 변경 (고객 -> 점주)
  Future<void> upgradeToStoreOwner({
    required String phone,
    required String businessNumber,
  }) async {
    final userId = currentUserId;
    if (userId == null) throw Exception('로그인이 필요합니다');

    // 1. 사용자 역할 업데이트
    await supabase
        .from('user_roles')
        .update({'role': 'store_owner'})
        .eq('user_id', userId);  // userId 사용

    // 2. 고객 정보 가져오기
    final customerInfo = await getCustomerProfile();
    final name = customerInfo?['name'] ?? currentUser?.userMetadata?['name'] ?? '점주';

    // 3. 점주 프로필 생성
    await supabase.from('store_owners').insert({
      'user_id': userId,  // userId 사용
      'name': name,
      'phone': phone,
      'business_number': businessNumber,
    });
  }
}

final supabaseService = SupabaseService();

final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  return supabaseService;
});