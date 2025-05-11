import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eatq/core/services/supabase_service.dart';
import 'package:eatq/models/store.dart';

class StoreController {
  final SupabaseService _supabaseService;

  StoreController(this._supabaseService);

  // 인기 매장 조회
  Future<List<Store>> getPopularStores() async {
    try {
      final response = await _supabaseService.supabase
          .from('stores')
          .select()
          .eq('is_active', true)
          .order('created_at', ascending: false)
          .limit(10);

      return (response as List).map((store) => Store.fromJson(store)).toList();
    } catch (e) {
      print('getPopularStores 오류: $e');
      // 개발 중이므로 임시 데이터 반환
      return [
        Store(
          id: '1',
          ownerId: 'owner1',
          name: '맛있는 레스토랑',
          address: '서울시 강남구',
          phone: '02-1234-5678',
          businessHours: {
            'monday': {'open': '09:00', 'close': '22:00'},
            'tuesday': {'open': '09:00', 'close': '22:00'},
            'wednesday': {'open': '09:00', 'close': '22:00'},
            'thursday': {'open': '09:00', 'close': '22:00'},
            'friday': {'open': '09:00', 'close': '22:00'},
            'saturday': {'open': '09:00', 'close': '22:00'},
            'sunday': {'open': '09:00', 'close': '22:00'},
          },
          category: '한식',
          createdAt: DateTime.now(),
          isActive: true,
        ),
        Store(
          id: '2',
          ownerId: 'owner2',
          name: '피자파티',
          address: '서울시 서초구',
          phone: '02-2345-6789',
          businessHours: {
            'monday': {'open': '11:00', 'close': '23:00'},
            'tuesday': {'open': '11:00', 'close': '23:00'},
            'wednesday': {'open': '11:00', 'close': '23:00'},
            'thursday': {'open': '11:00', 'close': '23:00'},
            'friday': {'open': '11:00', 'close': '23:00'},
            'saturday': {'open': '11:00', 'close': '23:00'},
            'sunday': {'open': '11:00', 'close': '23:00'},
          },
          logoUrl: 'https://via.placeholder.com/150',
          category: '피자',
          createdAt: DateTime.now(),
          isActive: true,
        ),
      ];
    }
  }

  // 매장 검색
  Future<List<Store>> searchStores(String query) async {
    try {
      final response = await _supabaseService.supabase
          .from('stores')
          .select()
          .eq('is_active', true)
          .ilike('name', '%$query%')
          .order('created_at', ascending: false);

      return (response as List).map((store) => Store.fromJson(store)).toList();
    } catch (e) {
      print('searchStores 오류: $e');
      return [];
    }
  }

  // 매장 상세 정보 조회
  Future<Store?> getStoreById(String id) async {
    try {
      final response = await _supabaseService.supabase
          .from('stores')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) return null;
      return Store.fromJson(response);
    } catch (e) {
      print('getStoreById 오류: $e');
      return null;
    }
  }
}

// Providers
final storeControllerProvider = Provider<StoreController>((ref) {
  return StoreController(supabaseService);
});

// 인기 매장 목록 Provider
final popularStoresProvider = FutureProvider<List<Store>>((ref) async {
  final storeController = ref.watch(storeControllerProvider);
  return storeController.getPopularStores();
});

// 매장 검색 결과 Provider
final storeSearchProvider = FutureProvider.family<List<Store>, String>((ref, query) async {
  final storeController = ref.watch(storeControllerProvider);
  return storeController.searchStores(query);
});

// 매장 상세 정보 Provider
final storeDetailProvider = FutureProvider.family<Store?, String>((ref, storeId) async {
  final storeController = ref.watch(storeControllerProvider);
  return storeController.getStoreById(storeId);
});