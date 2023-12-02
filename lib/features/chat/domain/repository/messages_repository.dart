import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/chat/domain/entity/message_entity.dart';

abstract class MessagesRepository {
  Future<ApiResult<MessagesEntity>> getMessagesByConversationID({
    required String conversationId,
    String? limit,
    String? page,
  });

  Future<ApiResult<String>> deleteCategoryByID(
    String id, {
    required String sender,
    required String conversationId,
    required String sellerId,
    required String userId,
  });
}
