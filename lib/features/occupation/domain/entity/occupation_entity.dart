// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fiverr/core/common/entity/seller_custom_entity.dart';

class OccupationEntity extends Equatable {
  final String id;
  final String occupation;
  final String specialization;
  final SellerCustomEntity seller;
  final String form;
  final String to;
  final String createdAt;
  final String updatedAt;

  const OccupationEntity({
    required this.id,
    required this.occupation,
    required this.specialization,
    required this.seller,
    required this.form,
    required this.to,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      occupation,
      specialization,
      seller,
      form,
      to,
      createdAt,
      updatedAt,
    ];
  }
}
