// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:fiverr/features/order/data/model/order_model.dart';
import 'package:flutter/foundation.dart';

import 'package:fiverr/features/order/domain/entity/orders_entity.dart';

class OrdersModel extends OrdersEntity {
  final List<OrderModel> result;
  const OrdersModel({
    required super.length,
    required this.result,
  }) : super(result: result);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'length': length,
      'result': result.map((x) => x.toMap()).toList(),
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      length: map['length'] as int,
      result: List<OrderModel>.from(
        (map['result'] as dynamic).map<OrderModel>(
          (x) => OrderModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersModel.fromJson(String source) =>
      OrdersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrdersModel(length: $length, result: $result)';

  @override
  bool operator ==(covariant OrdersModel other) {
    if (identical(this, other)) return true;

    return other.length == length && listEquals(other.result, result);
  }

  @override
  int get hashCode => length.hashCode ^ result.hashCode;
}
