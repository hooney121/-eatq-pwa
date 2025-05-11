class Store {
  final String id;
  final String ownerId;
  final String name;
  final String address;
  final String phone;
  final Map<String, dynamic> businessHours;
  final String? logoUrl;
  final String? description;
  final String category;
  final DateTime createdAt;
  final bool isActive;

  Store({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.address,
    required this.phone,
    required this.businessHours,
    this.logoUrl,
    this.description,
    required this.category,
    required this.createdAt,
    required this.isActive,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      ownerId: json['owner_id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      businessHours: json['business_hours'],
      logoUrl: json['logo_url'],
      description: json['description'],
      category: json['category'],
      createdAt: DateTime.parse(json['created_at']),
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'address': address,
      'phone': phone,
      'business_hours': businessHours,
      'logo_url': logoUrl,
      'description': description,
      'category': category,
      'created_at': createdAt.toIso8601String(),
      'is_active': isActive,
    };
  }
}