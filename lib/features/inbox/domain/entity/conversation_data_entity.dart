import 'package:equatable/equatable.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_seller_entity.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_user_entity.dart';

class ConversationDataEntity extends Equatable {
  final String id;
  final ConversationSellerEntity seller;
  final ConversationUserEntity user;
  final String lastMessage;
  final String createdAt;
  final String updatedAt;

  const ConversationDataEntity({
    required this.id,
    required this.seller,
    required this.user,
    required this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      seller,
      user,
      lastMessage,
      createdAt,
      updatedAt,
    ];
  }
}
