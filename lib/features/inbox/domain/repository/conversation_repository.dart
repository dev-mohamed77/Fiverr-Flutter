import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_data_entity.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_entity.dart';

abstract class IConversationRepository {
  Future<ApiResult<ConversationDataEntity>> createConversation({
    required String sellerID,
  });
  Future<ApiResult<ConversationEntity>> getConversationsBySellerId({
    required String sellerID,
    String? limit,
    String? page,
  });
  Future<ApiResult<ConversationEntity>> getConversationsByUserId({
    String? limit,
    String? page,
  });
  Future<ApiResult<ConversationDataEntity?>>
      getConversationByUserIdAndSellerId({
    required String sellerID,
    required String userID,
  });
}
