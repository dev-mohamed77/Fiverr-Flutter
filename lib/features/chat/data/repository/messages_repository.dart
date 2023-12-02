// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/chat/data/data_source/messages_remote_data_source.dart';
import 'package:fiverr/features/chat/domain/entity/message_entity.dart';
import 'package:fiverr/features/chat/domain/repository/messages_repository.dart';

class MessagesRepositoryImp implements MessagesRepository {
  final MessagesRemoteDataSource remoteDataSource;

  MessagesRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<MessagesEntity>> getMessagesByConversationID({
    required String conversationId,
    String? limit,
    String? page,
  }) async {
    try {
      final data = await remoteDataSource.getMessagesByConversationID(
        conversationId: conversationId,
        limit: limit,
        page: page,
      );

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteCategoryByID(
    String id, {
    required String sender,
    required String conversationId,
    required String sellerId,
    required String userId,
  }) async {
    try {
      final data = await remoteDataSource.deleteCategoryByID(
        id,
        sender: sender,
        conversationId: conversationId,
        sellerId: sellerId,
        userId: userId,
      );

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
