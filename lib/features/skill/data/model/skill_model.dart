// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:fiverr/core/common/model/seller_custom_model.dart';
import 'package:fiverr/features/skill/domain/entity/skill_entity.dart';

class SkillModel extends SkillEntity {
  final SellerCustomModel seller;

  const SkillModel({
    required super.id,
    required super.skill,
    required super.level,
    required this.seller,
    required super.createdAt,
    required super.updatedAt,
  }) : super(seller: seller);

  SkillModel copyWith({
    String? id,
    String? skill,
    String? level,
    SellerCustomModel? seller,
    String? createdAt,
    String? updatedAt,
  }) {
    return SkillModel(
      id: id ?? this.id,
      skill: skill ?? this.skill,
      level: level ?? this.level,
      seller: seller ?? this.seller,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'skill': skill,
      'level': level,
      'seller': seller.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory SkillModel.fromMap(Map<String, dynamic> map) {
    return SkillModel(
      id: map['id'] ?? "",
      skill: map['skill'] ?? "",
      level: map['level'] ?? "",
      seller: SellerCustomModel.fromMap(map['seller'] as Map<String, dynamic>),
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SkillModel.fromJson(String source) =>
      SkillModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SkillModel(id: $id, skill: $skill, level: $level, seller: $seller, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant SkillModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.skill == skill &&
        other.level == level &&
        other.seller == seller &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        skill.hashCode ^
        level.hashCode ^
        seller.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
