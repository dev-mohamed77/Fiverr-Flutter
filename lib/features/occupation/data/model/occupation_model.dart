// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fiverr/core/common/model/seller_custom_model.dart';
import 'package:fiverr/features/occupation/domain/entity/occupation_entity.dart';

class OccupationModel extends OccupationEntity {
  final SellerCustomModel seller;

  const OccupationModel({
    required super.id,
    required super.occupation,
    required super.specialization,
    required this.seller,
    required super.form,
    required super.to,
    required super.createdAt,
    required super.updatedAt,
  }) : super(seller: seller);

  OccupationModel copyWith({
    String? id,
    String? occupation,
    String? specialization,
    SellerCustomModel? seller,
    String? form,
    String? to,
    String? createdAt,
    String? updatedAt,
  }) {
    return OccupationModel(
      id: id ?? this.id,
      occupation: occupation ?? this.occupation,
      specialization: specialization ?? this.specialization,
      seller: seller ?? this.seller,
      form: form ?? this.form,
      to: to ?? this.to,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'occupation': occupation,
      'specialization': specialization,
      'seller': seller.toMap(),
      'form': form,
      'to': to,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory OccupationModel.fromMap(Map<String, dynamic> map) {
    return OccupationModel(
      id: map['id'] ?? "",
      occupation: map['occupation'] ?? "",
      specialization: map['specialization'] ?? "",
      seller: SellerCustomModel.fromMap(map['seller'] as Map<String, dynamic>),
      form: map['form'] ?? "",
      to: map['to'] ?? "",
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory OccupationModel.fromJson(String source) =>
      OccupationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OccupationModel(id: $id, occupation: $occupation, specialization: $specialization, seller: $seller, form: $form, to: $to, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant OccupationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.occupation == occupation &&
        other.specialization == specialization &&
        other.seller == seller &&
        other.form == form &&
        other.to == to &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        occupation.hashCode ^
        specialization.hashCode ^
        seller.hashCode ^
        form.hashCode ^
        to.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
