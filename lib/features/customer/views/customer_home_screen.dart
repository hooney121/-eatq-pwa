import 'package:flutter/material.dart';
import 'package:eatq/config/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _currentIndex = 0;

  // 샘플 데이터 - 실제로는 Supabase에서 가져올 예정
  final List<Map<String, dynamic>> _popularStores = [
    {
      'id': '1',
      'name': '민혁이의 맘스터치',
      'category': '양식',
      'location': '용인시 성복동',
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=500',
      'distance': '0.5km',
    },
    {
      'id': '2',
      'name': '피자파티',
      'category': '피자',
      'location': '서울시 서초구',
      'rating': 4.5,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
      'distance': '1.2km',
    },
    {
      'id': '3',
      'name': '버거킹덤',
      'category': '햄버거',
      'location': '서울시 마포구',
      'rating': 4.3,
      'image': 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=500',
      'distance': '2.0km',
    },
    {
      'id': '4',
      'name': '스시마스터',
      'category': '일식',
      'location': '서울시 용산구',
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=500',
      'distance': '1.5km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('EatQ'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // 프로필 화면으로 이동
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(),
          _buildStoresTab(),
          _buildOrdersTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: '매장',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: '주문',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 환영 메시지
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: AppTheme.primaryGradient,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '환영합니다!',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '오늘은 어떤 음식을 즐기실 건가요?',
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 32,
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // 빠른 주문 카드
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '빠른 주문하기',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // QR 스캔 기능 실행
                    },
                    icon: Icon(Icons.qr_code_scanner),
                    label: Text('QR코드로 테이블 스캔'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          // 인기 매장 섹션
          Text(
            '인기 매장',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),

          // 인기 매장 그리드
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _popularStores.length,
            itemBuilder: (context, index) {
              final store = _popularStores[index];
              return _buildStoreCard(store);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store) {
    return GestureDetector(
      onTap: () {
        // 매장 상세 페이지로 이동
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 매장 이미지
            AspectRatio(
              aspectRatio: 1.2,
              child: CachedNetworkImage(
                imageUrl: store['image'],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.restaurant, size: 48, color: Colors.grey[600]),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.category, size: 14, color: AppTheme.secondaryTextColor),
                      SizedBox(width: 4),
                      Text(
                        store['category'],
                        style: TextStyle(
                          color: AppTheme.secondaryTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.amber),
                      SizedBox(width: 4),
                      Text(
                        '${store['rating']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.location_on, size: 14, color: AppTheme.secondaryTextColor),
                      SizedBox(width: 4),
                      Text(
                        store['distance'],
                        style: TextStyle(
                          color: AppTheme.secondaryTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 매장 탭 화면
  Widget _buildStoresTab() {
    return Center(
      child: Text('매장 화면 준비 중...'),
    );
  }

  // 주문 탭 화면
  Widget _buildOrdersTab() {
    return Center(
      child: Text('주문 내역 화면 준비 중...'),
    );
  }
}