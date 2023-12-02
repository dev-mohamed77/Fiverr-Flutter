// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:fiverr/features/inbox/domain/entity/conversation_user_entity.dart';

class ConversationUserModel extends ConversationUserEntity {
  const ConversationUserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  ConversationUserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return ConversationUserModel(
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

  factory ConversationUserModel.fromMap(Map<String, dynamic> map) {
    return ConversationUserModel(
      id: map['id'] ?? "",
      name: map.containsKey("name") ? map['name'] ?? "" : "",
      email: map.containsKey("email") ? map['email'] ?? "" : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationUserModel.fromJson(String source) =>
      ConversationUserModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ConversationUserModel(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(covariant ConversationUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}
