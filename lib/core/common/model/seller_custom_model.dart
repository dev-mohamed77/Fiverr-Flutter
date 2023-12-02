// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:fiverr/core/common/entity/seller_custom_entity.dart';

class SellerCustomModel extends SellerCustomEntity {
  const SellerCustomModel({
    required super.id,
    required super.fullName,
  });

  SellerCustomModel copyWith({
    String? id,
    String? fullName,
  }) {
    return SellerCustomModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
    };
  }

  factory SellerCustomModel.fromMap(Map<String, dynamic> map) {
    return SellerCustomModel(
      id: map['id'] ?? "",
      fullName: map.containsKey("fullName") ? map['fullName'] : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerCustomModel.fromJson(String source) =>
      SellerCustomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SellerCustomModel(id: $id, fullName: $fullName)';

  @override
  bool operator ==(covariant SellerCustomModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.fullName == fullName;
  }

  @override
  int get hashCode => id.hashCode ^ fullName.hashCode;
}
