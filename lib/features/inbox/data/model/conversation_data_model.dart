// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fiverr/features/inbox/data/model/conversation_user_model.dart';
import 'package:fiverr/features/inbox/data/model/coversation_seller_model.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_data_entity.dart';

class ConversationDataModel extends ConversationDataEntity {
  final ConversationSellerModel seller;
  final ConversationUserModel user;
  const ConversationDataModel({
    required super.id,
    required this.seller,
    required this.user,
    required super.lastMessage,
    required super.createdAt,
    required super.updatedAt,
  }) : super(seller: seller, user: user);

  ConversationDataModel copyWith({
    String? id,
    ConversationSellerModel? seller,
    ConversationUserModel? user,
    String? lastMessage,
    String? createdAt,
    String? updatedAt,
  }) {
    return ConversationDataModel(
      id: id ?? this.id,
      seller: seller ?? this.seller,
      user: user ?? this.user,
      lastMessage: lastMessage ?? this.lastMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'seller': seller.toMap(),
      'user': user.toMap(),
      'lastMessage': lastMessage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ConversationDataModel.fromMap(Map<String, dynamic> map) {
    return ConversationDataModel(
      id: map['id'] ?? "",
      seller: ConversationSellerModel.fromMap(
          map['seller'] as Map<String, dynamic>),
      user: ConversationUserModel.fromMap(map['user'] as Map<String, dynamic>),
      lastMessage: map['lastMessage'] ?? "",
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationDataModel.fromJson(String source) =>
      ConversationDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConversationDataModel(id: $id, seller: $seller, user: $user, lastMessage: $lastMessage, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ConversationDataModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.seller == seller &&
        other.user == user &&
        other.lastMessage == lastMessage &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        seller.hashCode ^
        user.hashCode ^
        lastMessage.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
