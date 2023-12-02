// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/inbox/data/data_source/conversation_remote_data_source.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_data_entity.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_entity.dart';
import 'package:fiverr/features/inbox/domain/repository/conversation_repository.dart';

class ConversationRepositoryImp implements IConversationRepository {
  final ConversationRemoteDataSource remoteDataSource;
  ConversationRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<ConversationDataEntity>> createConversation({
    required String sellerID,
  }) async {
    try {
      final result =
          await remoteDataSource.createConversation(sellerID: sellerID);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<ConversationDataEntity?>>
      getConversationByUserIdAndSellerId({
    required String sellerID,
    required String userID,
  }) async {
    try {
      final result = await remoteDataSource.getConversationByUserIdAndSellerId(
        sellerID: sellerID,
        userID: userID,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<ConversationEntity>> getConversationsBySellerId({
    required String sellerID,
    String? limit,
    String? page,
  }) async {
    try {
      final result = await remoteDataSource.getConversationsBySellerId(
        sellerID: sellerID,
        page: page,
        limit: limit,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<ConversationEntity>> getConversationsByUserId({
    String? limit,
    String? page,
  }) async {
    try {
      final result = await remoteDataSource.getConversationsByUserId(
        page: page,
        limit: limit,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
