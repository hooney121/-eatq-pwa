class MenuItem {
  final String id;
  final String storeId;
  final String? categoryId;
  final String name;
  final String? description;
  final int price;
  final String? imageUrl;
  final bool isAvailable;
  final bool isPopular;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? preparationTime;

  MenuItem({
    required this.id,
    required this.storeId,
    this.categoryId,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    required this.isAvailable,
    required this.isPopular,
    required this.createdAt,
    required this.updatedAt,
    this.preparationTime,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      storeId: json['store_id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['image_url'],
      isAvailable: json['is_available'],
      isPopular: json['is_popular'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      preparationTime: json['preparation_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'is_available': isAvailable,
      'is_popular': isPopular,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'preparation_time': preparationTime,
    };
  }
}