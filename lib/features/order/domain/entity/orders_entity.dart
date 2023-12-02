// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:fiverr/features/order/domain/entity/order_entity.dart';

class OrdersEntity extends Equatable {
  final int length;
  final List<OrderEntity> result;

  const OrdersEntity({
    required this.length,
    required this.result,
  });

  @override
  List<Object> get props => [length, result];
}
