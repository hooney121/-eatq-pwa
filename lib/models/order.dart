class Order {
  final String id;
  final String storeId;
  final String? customerId;
  final String? tableId;
  final String orderNumber;
  final int totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? paymentMethod;
  final String paymentStatus;
  final String? specialInstructions;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.storeId,
    this.customerId,
    this.tableId,
    required this.orderNumber,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.paymentMethod,
    required this.paymentStatus,
    this.specialInstructions,
    this.items = const [],
  });

  factory Order.fromJson(Map<String, dynamic> json, {List<OrderItem>? items}) {
    return Order(
      id: json['id'],
      storeId: json['store_id'],
      customerId: json['customer_id'],
      tableId: json['table_id'],
      orderNumber: json['order_number'],
      totalAmount: json['total_amount'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      specialInstructions: json['special_instructions'],
      items: items ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'customer_id': customerId,
      'table_id': tableId,
      'order_number': orderNumber,
      'total_amount': totalAmount,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'special_instructions': specialInstructions,
    };
  }
}

class OrderItem {
  final String id;
  final String orderId;
  final String? menuItemId;
  final int quantity;
  final int unitPrice;
  final int subtotal;
  final String? specialInstructions;
  final DateTime createdAt;
  final List<OrderItemOption> options;

  OrderItem({
    required this.id,
    required this.orderId,
    this.menuItemId,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    this.specialInstructions,
    required this.createdAt,
    this.options = const [],
  });

  factory OrderItem.fromJson(Map<String, dynamic> json, {List<OrderItemOption>? options}) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      menuItemId: json['menu_item_id'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      subtotal: json['subtotal'],
      specialInstructions: json['special_instructions'],
      createdAt: DateTime.parse(json['created_at']),
      options: options ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'menu_item_id': menuItemId,
      'quantity': quantity,
      'unit_price': unitPrice,
      'subtotal': subtotal,
      'special_instructions': specialInstructions,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class OrderItemOption {
  final String id;
  final String orderItemId;
  final String? optionItemId;
  final String optionName;
  final int optionPrice;

  OrderItemOption({
    required this.id,
    required this.orderItemId,
    this.optionItemId,
    required this.optionName,
    required this.optionPrice,
  });

  factory OrderItemOption.fromJson(Map<String, dynamic> json) {
    return OrderItemOption(
      id: json['id'],
      orderItemId: json['order_item_id'],
      optionItemId: json['option_item_id'],
      optionName: json['option_name'],
      optionPrice: json['option_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_item_id': orderItemId,
      'option_item_id': optionItemId,
      'option_name': optionName,
      'option_price': optionPrice,
    };
  }
}