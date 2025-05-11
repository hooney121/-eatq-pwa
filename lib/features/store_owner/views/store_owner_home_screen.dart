import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:eatq/core/services/auth_service.dart';
import 'package:eatq/core/services/supabase_service.dart';

class StoreOwnerHomeScreen extends ConsumerStatefulWidget {
  const StoreOwnerHomeScreen({super.key});

  @override
  ConsumerState<StoreOwnerHomeScreen> createState() => _StoreOwnerHomeScreenState();
}

class _StoreOwnerHomeScreenState extends ConsumerState<StoreOwnerHomeScreen> {
  int _currentIndex = 0;

  // 화면에 표시할 본문 콘텐츠 생성
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildStoresTab();
      case 2:
        return _buildOrdersTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '점주님 환영합니다!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '매장 관리',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.push('/owner/stores');
                    },
                    icon: const Icon(Icons.store),
                    label: const Text('내 매장 관리하기'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '최근 주문',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 개발 중이므로 임시 데이터
                  _buildOrderItem(
                    orderNumber: 'ORD12345',
                    dateTime: '2025-05-11 10:30',
                    table: '테이블 3',
                    amount: '28,000원',
                    status: '준비 중',
                    statusColor: Colors.orange,
                  ),
                  const Divider(),
                  _buildOrderItem(
                    orderNumber: 'ORD12344',
                    dateTime: '2025-05-11 10:15',
                    table: '테이블 1',
                    amount: '42,000원',
                    status: '완료',
                    statusColor: Colors.green,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      // 모든 주문 보기
                    },
                    child: const Text('모든 주문 보기'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String orderNumber,
    required String dateTime,
    required String table,
    required String amount,
    required String status,
    required Color statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderNumber,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  dateTime,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(table),
          ),
          Expanded(
            flex: 2,
            child: Text(amount),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(color: statusColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoresTab() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getMyStores(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
        }

        final stores = snapshot.data ?? [];

        if (stores.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('등록된 매장이 없습니다.'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // 매장 추가 화면으로 이동
                  },
                  child: const Text('매장 추가하기'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: stores.length,
          itemBuilder: (context, index) {
            final store = stores[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.store)),
                title: Text(store['name']),
                subtitle: Text(store['address']),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.push('/owner/store/${store['id']}');
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _getMyStores() async {
    try {
      // 임시 데이터 반환 (개발 중)
      await Future.delayed(const Duration(seconds: 1));
      return [
        {
          'id': '1',
          'name': '맛있는 레스토랑',
          'address': '서울시 강남구',
          'is_active': true,
        },
        {
          'id': '2',
          'name': '피자파티',
          'address': '서울시 서초구',
          'is_active': true,
        },
      ];
    } catch (e) {
      return [];
    }
  }

  Widget _buildOrdersTab() {
    return const Center(child: Text('주문 내역'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EatQ 점주'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // 프로필 화면으로 이동
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final authService = ref.read(authServiceProvider);
              await authService.signOut();
              if (mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
        onPressed: () {
          // 새 매장 추가
        },
        child: const Icon(Icons.add),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: '매장',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: '주문',
          ),
        ],
      ),
    );
  }
}