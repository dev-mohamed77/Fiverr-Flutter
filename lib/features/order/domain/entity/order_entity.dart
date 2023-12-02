// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fiverr/features/order/domain/entity/order_gig_entity.dart';
import 'package:fiverr/features/order/domain/entity/order_seller_entity.dart';
import 'package:fiverr/features/order/domain/entity/order_user_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final String description;
  final String payment;
  final int serviceFee;
  final int subTotal;
  final int total;
  final int deliveryTime;
  final String statusUser;
  final String statusSeller;
  final OrderGigEntity gig;
  final OrderSellerEntity seller;
  final OrderUserEntity user;
  final String createdAt;
  final String updatedAt;

  const OrderEntity({
    required this.id,
    required this.description,
    required this.payment,
    required this.serviceFee,
    required this.subTotal,
    required this.total,
    required this.deliveryTime,
    required this.statusUser,
    required this.statusSeller,
    required this.gig,
    required this.seller,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      description,
      payment,
      serviceFee,
      subTotal,
      total,
      deliveryTime,
      statusUser,
      statusSeller,
      gig,
      seller,
      user,
      createdAt,
      updatedAt,
    ];
  }
}
