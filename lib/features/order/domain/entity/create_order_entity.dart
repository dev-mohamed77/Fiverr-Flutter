// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CreateOrderEntity extends Equatable {
  final String seller;
  final String gig;
  final int deliveryTime;
  final String payment;
  final String description;
  final int serviceFee;
  final int subTotal;

  const CreateOrderEntity({
    required this.seller,
    required this.gig,
    required this.deliveryTime,
    required this.payment,
    required this.description,
    required this.serviceFee,
    required this.subTotal,
  });

  @override
  List<Object> get props {
    return [
      seller,
      gig,
      deliveryTime,
      payment,
      description,
      serviceFee,
      subTotal,
    ];
  }

  CreateOrderEntity copyWith({
    String? seller,
    String? gig,
    int? deliveryTime,
    String? payment,
    String? description,
    int? serviceFee,
    int? subTotal,
  }) {
    return CreateOrderEntity(
      seller: seller ?? this.seller,
      gig: gig ?? this.gig,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      payment: payment ?? this.payment,
      description: description ?? this.description,
      serviceFee: serviceFee ?? this.serviceFee,
      subTotal: subTotal ?? this.subTotal,
    );
  }
}
