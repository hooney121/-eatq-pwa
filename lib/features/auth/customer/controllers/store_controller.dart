import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eatq/core/services/supabase_service.dart';
import 'package:eatq/models/store.dart';

class StoreController {
  final SupabaseService _supabaseService;

  StoreController(this._supabaseService);

  Future<List<Store>> getPopularStores() async {
    final response = await _supabaseService.supabase
        .from('stores')
        .select()
        .eq('is_active', true)
        .order('created_at', ascending: false)
        .limit(10);

    return response.map((store) => Store.fromJson(store)).toList();
  }

  Future<List<Store>> searchStores(String query) async {
    final response = await _supabaseService.supabase
        .from('stores')
        .select()
        .eq('is_active', true)
        .ilike('name', '%$query%')
        .order('created_at', ascending: false);

    return response.map((store) => Store.fromJson(store)).toList();
  }

  Future<Store> getStoreById(String id) async {
    final response = await _supabaseService.supabase
        .from('stores')
        .select()
        .eq('id', id)
        .single();

    return Store.fromJson(response);
  }
}

final storeControllerProvider = Provider<StoreController>((ref) {
  return StoreController(supabaseService);
});

final popularStoresProvider = FutureProvider<List<Store>>((ref) {
  final storeController = ref.watch(storeControllerProvider);
  return storeController.getPopularStores();
});

final storeProvider = FutureProvider.family<Store, String>((ref, storeId) {
  final storeController = ref.watch(storeControllerProvider);
  return storeController.getStoreById(storeId);
});