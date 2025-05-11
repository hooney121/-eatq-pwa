class Customer {
  final String id;
  final String userId;
  final String email;
  final String? phone;
  final String name;
  final String? profileImageUrl;
  final DateTime createdAt;

  Customer({
    required this.id,
    required this.userId,
    required this.email,
    this.phone,
    required this.name,
    this.profileImageUrl,
    required this.createdAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      userId: json['user_id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      profileImageUrl: json['profile_image_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'email': email,
      'phone': phone,
      'name': name,
      'profile_image_url': profileImageUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}