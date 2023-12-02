import 'package:equatable/equatable.dart';

class OrderGigEntity extends Equatable {
  final String id;
  final String title;
  final String coverImage;
  final int price;
  final int deliveryTime;

  const OrderGigEntity({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.price,
    required this.deliveryTime,
  });

  @override
  List<Object> get props => [id, title, coverImage, price, deliveryTime];
}
