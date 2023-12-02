import 'dart:convert';

import 'package:fiverr/features/order/domain/entity/order_gig_entity.dart';

class OrderGigModel extends OrderGigEntity {
  const OrderGigModel({
    required super.id,
    required super.title,
    required super.coverImage,
    required super.price,
    required super.deliveryTime,
  });

  OrderGigModel copyWith({
    String? id,
    String? title,
    String? coverImage,
    int? price,
    int? deliveryTime,
  }) {
    return OrderGigModel(
      id: id ?? this.id,
      title: title ?? this.title,
      coverImage: coverImage ?? this.coverImage,
      price: price ?? this.price,
      deliveryTime: deliveryTime ?? this.deliveryTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'coverImage': coverImage,
      'price': price,
      'deliveryTime': deliveryTime,
    };
  }

  factory OrderGigModel.fromMap(Map<String, dynamic> map) {
    return OrderGigModel(
      id: map['id'] ?? "",
      title: map.containsKey('title') ? map['title'] ?? "" : "",
      coverImage: map.containsKey('coverImage') ? map['coverImage'] ?? "" : "",
      price: map.containsKey('coverImage') ? map['price'] ?? 0 : 0,
      deliveryTime:
          map.containsKey('deliveryTime') ? map['deliveryTime'] ?? 0 : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderGigModel.fromJson(String source) =>
      OrderGigModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderGigModel(id: $id, title: $title, coverImage: $coverImage, price: $price)';
  }

  @override
  bool operator ==(covariant OrderGigModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.coverImage == coverImage &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ coverImage.hashCode ^ price.hashCode;
  }
}
