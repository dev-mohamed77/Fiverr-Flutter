// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class MessagesEntity extends Equatable {
  final bool status;
  final int length;
  final List<MessageDataEntity> result;

  const MessagesEntity({
    required this.status,
    required this.length,
    required this.result,
  });

  @override
  List<Object> get props => [status, length, result];
}

class MessageDataEntity extends Equatable {
  final String id;
  final String message;
  final String sender;
  final MessageConversationEntity conversation;
  final MessageSellerEntity seller;
  final MessageUserEntity user;
  final String createdAt;
  final String updatedAt;

  const MessageDataEntity({
    required this.id,
    required this.message,
    required this.sender,
    required this.conversation,
    required this.seller,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [message, sender, conversation, seller, user, createdAt, updatedAt];
  }
}

class MessageConversationEntity extends Equatable {
  final String id;

  const MessageConversationEntity({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class MessageSellerEntity extends Equatable {
  final String id;
  final String fullName;
  final String displayName;
  final String picture;

  const MessageSellerEntity({
    required this.id,
    required this.fullName,
    required this.displayName,
    required this.picture,
  });

  @override
  List<Object> get props => [id, fullName, displayName, picture];
}

class MessageUserEntity extends Equatable {
  final String id;
  final String name;
  final String email;

  const MessageUserEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object> get props => [id, name, email];
}
