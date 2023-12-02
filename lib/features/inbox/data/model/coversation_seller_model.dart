// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fiverr/features/inbox/domain/entity/conversation_seller_entity.dart';

class ConversationSellerModel extends ConversationSellerEntity {
  const ConversationSellerModel({
    required super.id,
    required super.fullName,
    required super.displayName,
    required super.picture,
  });

  ConversationSellerModel copyWith({
    String? id,
    String? fullName,
    String? displayName,
    String? picture,
  }) {
    return ConversationSellerModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      displayName: displayName ?? this.displayName,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'displayName': displayName,
      'picture': picture,
    };
  }

  factory ConversationSellerModel.fromMap(Map<String, dynamic> map) {
    return ConversationSellerModel(
      id: map['id'] as String,
      fullName: map.containsKey('fullName') ? map['fullName'] ?? "" : "",
      displayName:
          map.containsKey('displayName') ? map['displayName'] ?? "" : "",
      picture: map.containsKey('picture') ? map['picture'] ?? "" : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationSellerModel.fromJson(String source) =>
      ConversationSellerModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConversationSellerModel(id: $id, fullName: $fullName, displayName: $displayName, picture: $picture)';
  }

  @override
  bool operator ==(covariant ConversationSellerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.displayName == displayName &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        displayName.hashCode ^
        picture.hashCode;
  }
}
