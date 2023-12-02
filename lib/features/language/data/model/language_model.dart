// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fiverr/core/common/model/seller_custom_model.dart';
import 'package:fiverr/features/language/domain/entity/language_entity.dart';

class LanguageModel extends LanguageEntity {
  final SellerCustomModel seller;

  const LanguageModel({
    required super.id,
    required super.language,
    required super.level,
    required this.seller,
    required super.createdAt,
    required super.updatedAt,
  }) : super(seller: seller);

  LanguageModel copyWith({
    String? id,
    String? language,
    String? level,
    SellerCustomModel? seller,
    String? createdAt,
    String? updatedAt,
  }) {
    return LanguageModel(
      id: id ?? this.id,
      language: language ?? this.language,
      level: level ?? this.level,
      seller: seller ?? this.seller,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'language': language,
      'level': level,
      'seller': seller.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      id: map['id'] ?? "",
      language: map['language'] ?? "",
      level: map['level'] ?? "",
      seller: SellerCustomModel.fromMap(map['seller'] as Map<String, dynamic>),
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageModel.fromJson(String source) =>
      LanguageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LanguageModel(id: $id, language: $language, level: $level, seller: $seller, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant LanguageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.language == language &&
        other.level == level &&
        other.seller == seller &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        language.hashCode ^
        level.hashCode ^
        seller.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
