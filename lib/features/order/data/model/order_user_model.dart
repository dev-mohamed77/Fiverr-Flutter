import 'dart:convert';

import 'package:fiverr/features/order/domain/entity/order_user_entity.dart';

class OrderUserModel extends OrderUserEntity {
  const OrderUserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  OrderUserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return OrderUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory OrderUserModel.fromMap(Map<String, dynamic> map) {
    return OrderUserModel(
      id: map['id'] ?? "",
      name: map.containsKey("name") ? map['name'] ?? "" : "",
      email: map.containsKey("email") ? map['email'] ?? "" : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderUserModel.fromJson(String source) =>
      OrderUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderUserModel(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(covariant OrderUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}
