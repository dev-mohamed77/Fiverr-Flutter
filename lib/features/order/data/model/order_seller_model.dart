import 'dart:convert';

import 'package:fiverr/features/order/domain/entity/order_seller_entity.dart';

class OrderSellerModel extends OrderSellerEntity {
  const OrderSellerModel({
    required super.id,
    required super.fullName,
    required super.displayName,
    required super.picture,
  });

  OrderSellerModel copyWith({
    String? id,
    String? fullName,
    String? displayName,
    String? picture,
  }) {
    return OrderSellerModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      displayName: displayName ?? this.displayName,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'displayName': displayName,
      'picture': picture,
    };
  }

  factory OrderSellerModel.fromMap(Map<String, dynamic> map) {
    return OrderSellerModel(
      id: map['id'] ?? "",
      fullName: map.containsKey("fullName") ? map['fullName'] ?? "" : "",
      displayName:
          map.containsKey("displayName") ? map['displayName'] ?? "" : "",
      picture: map.containsKey("picture") ? map['picture'] ?? "" : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSellerModel.fromJson(String source) =>
      OrderSellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderSellerModel(id: $id, fullName: $fullName, displayName: $displayName, picture: $picture)';
  }

  @override
  bool operator ==(covariant OrderSellerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.displayName == displayName &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        displayName.hashCode ^
        picture.hashCode;
  }
}
