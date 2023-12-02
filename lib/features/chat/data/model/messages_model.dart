// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fiverr/features/chat/domain/entity/message_entity.dart';

class MessagesModel extends MessagesEntity {
  final List<MessageDataModel> result;

  const MessagesModel({
    required super.status,
    required super.length,
    required this.result,
  }) : super(result: result);

  MessagesModel copyWith({
    bool? status,
    int? length,
    List<MessageDataModel>? result,
  }) {
    return MessagesModel(
      status: status ?? this.status,
      length: length ?? this.length,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'length': length,
      'result': result.map((x) => x.toMap()).toList(),
    };
  }

  factory MessagesModel.fromMap(Map<String, dynamic> map) {
    return MessagesModel(
      status: map['status'] ?? false,
      length: map['length'] ?? 0,
      result: List<MessageDataModel>.from(
        (map['result'] as List<dynamic>).map<MessageDataModel>(
          (x) => MessageDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagesModel.fromJson(String source) =>
      MessagesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessagesModel(status: $status, length: $length, result: $result)';

  @override
  bool operator ==(covariant MessagesModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.length == length &&
        listEquals(other.result, result);
  }

  @override
  int get hashCode => status.hashCode ^ length.hashCode ^ result.hashCode;
}

class MessageDataModel extends MessageDataEntity {
  final MessageConversationModel conversation;
  final MessageSellerModel seller;
  final MessageUserModel user;

  const MessageDataModel({
    required super.id,
    required super.message,
    required super.sender,
    required this.conversation,
    required this.seller,
    required this.user,
    required super.createdAt,
    required super.updatedAt,
  }) : super(conversation: conversation, seller: seller, user: user);

  MessageDataModel copyWith({
    String? id,
    String? message,
    String? sender,
    MessageConversationModel? conversation,
    MessageSellerModel? seller,
    MessageUserModel? user,
    String? createdAt,
    String? updatedAt,
  }) {
    return MessageDataModel(
      id: id ?? this.id,
      message: message ?? this.message,
      sender: sender ?? this.sender,
      conversation: conversation ?? this.conversation,
      seller: seller ?? this.seller,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'sender': sender,
      'conversation': conversation.toMap(),
      'seller': seller.toMap(),
      'user': user.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory MessageDataModel.fromMap(Map<String, dynamic> map) {
    return MessageDataModel(
      id: map['id'] ?? "",
      message: map['message'] ?? "",
      sender: map['sender'] ?? "",
      conversation: MessageConversationModel.fromMap(
          map['conversation'] as Map<String, dynamic>),
      seller: MessageSellerModel.fromMap(map['seller'] as Map<String, dynamic>),
      user: MessageUserModel.fromMap(map['user'] as Map<String, dynamic>),
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageDataModel.fromJson(String source) =>
      MessageDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageDataModel(message: $message, sender: $sender, conversation: $conversation, seller: $seller, user: $user)';
  }

  @override
  bool operator ==(covariant MessageDataModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.sender == sender &&
        other.conversation == conversation &&
        other.seller == seller &&
        other.user == user;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        sender.hashCode ^
        conversation.hashCode ^
        seller.hashCode ^
        user.hashCode;
  }
}

class MessageConversationModel extends MessageConversationEntity {
  const MessageConversationModel({
    required super.id,
  });

  MessageConversationModel copyWith({
    String? id,
  }) {
    return MessageConversationModel(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory MessageConversationModel.fromMap(Map<String, dynamic> map) {
    return MessageConversationModel(
      id: map['id'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageConversationModel.fromJson(String source) =>
      MessageConversationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessageConversationModel(id: $id)';

  @override
  bool operator ==(covariant MessageConversationModel other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class MessageSellerModel extends MessageSellerEntity {
  const MessageSellerModel({
    required super.id,
    required super.fullName,
    required super.displayName,
    required super.picture,
  });

  MessageSellerModel copyWith({
    String? id,
    String? fullName,
    String? displayName,
    String? picture,
  }) {
    return MessageSellerModel(
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

  factory MessageSellerModel.fromMap(Map<String, dynamic> map) {
    return MessageSellerModel(
      id: map['id'] ?? "",
      fullName: map['fullName'] ?? "",
      displayName: map['displayName'] ?? "",
      picture: map['picture'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageSellerModel.fromJson(String source) =>
      MessageSellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageSellerModel(id: $id, fullName: $fullName, displayName: $displayName, picture: $picture)';
  }

  @override
  bool operator ==(covariant MessageSellerModel other) {
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

class MessageUserModel extends MessageUserEntity {
  const MessageUserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  MessageUserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return MessageUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory MessageUserModel.fromMap(Map<String, dynamic> map) {
    return MessageUserModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageUserModel.fromJson(String source) =>
      MessageUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessageUserModel(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(covariant MessageUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}
