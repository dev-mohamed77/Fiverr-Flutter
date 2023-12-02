// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fiverr/features/order/data/model/order_gig_model.dart';
import 'package:fiverr/features/order/data/model/order_seller_model.dart';
import 'package:fiverr/features/order/data/model/order_user_model.dart';
import 'package:fiverr/features/order/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  final OrderGigModel gig;
  final OrderSellerModel seller;
  final OrderUserModel user;

  const OrderModel({
    required super.id,
    required super.description,
    required super.payment,
    required super.serviceFee,
    required super.subTotal,
    required super.total,
    required super.deliveryTime,
    required super.statusUser,
    required super.statusSeller,
    required this.gig,
    required this.seller,
    required this.user,
    required super.createdAt,
    required super.updatedAt,
  }) : super(gig: gig, seller: seller, user: user);

  OrderModel copyWith({
    String? id,
    String? description,
    String? payment,
    int? serviceFee,
    int? subTotal,
    int? total,
    int? deliveryTime,
    String? statusUser,
    String? statusSeller,
    OrderGigModel? gig,
    OrderSellerModel? seller,
    OrderUserModel? user,
    String? createdAt,
    String? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      description: description ?? this.description,
      payment: payment ?? this.payment,
      serviceFee: serviceFee ?? this.serviceFee,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.total,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      statusUser: statusUser ?? this.statusUser,
      statusSeller: statusSeller ?? this.statusSeller,
      gig: gig ?? this.gig,
      seller: seller ?? this.seller,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'payment': payment,
      'serviceFee': serviceFee,
      'subTotal': subTotal,
      'total': total,
      'deliveryTime': deliveryTime,
      'statusUser': statusUser,
      'statusSeller': statusSeller,
      'gig': gig.toMap(),
      'seller': seller.toMap(),
      'user': user.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? "",
      description: map['description'] ?? "",
      payment: map['payment'] ?? "",
      serviceFee: map['serviceFee'] ?? 0,
      subTotal: map['subTotal'] ?? 0,
      total: map['total'] ?? 0,
      deliveryTime: map['deliveryTime'] ?? 0,
      statusUser: map['statusUser'] ?? "",
      statusSeller: map['statusSeller'] ?? "",
      gig: OrderGigModel.fromMap(map['gig'] as Map<String, dynamic>),
      seller: OrderSellerModel.fromMap(map['seller'] as Map<String, dynamic>),
      user: OrderUserModel.fromMap(map['user'] as Map<String, dynamic>),
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, description: $description, payment: $payment, serviceFee: $serviceFee, subTotal: $subTotal, total: $total, deliveryTime: $deliveryTime, statusUser: $statusUser, statusSeller: $statusSeller, gig: $gig, seller: $seller, user: $user, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.payment == payment &&
        other.serviceFee == serviceFee &&
        other.subTotal == subTotal &&
        other.total == total &&
        other.deliveryTime == deliveryTime &&
        other.statusUser == statusUser &&
        other.statusSeller == statusSeller &&
        other.gig == gig &&
        other.seller == seller &&
        other.user == user &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        payment.hashCode ^
        serviceFee.hashCode ^
        subTotal.hashCode ^
        total.hashCode ^
        deliveryTime.hashCode ^
        statusUser.hashCode ^
        statusSeller.hashCode ^
        gig.hashCode ^
        seller.hashCode ^
        user.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
