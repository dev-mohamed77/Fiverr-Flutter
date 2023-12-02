import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_data_entity.dart';
import 'package:fiverr/features/inbox/domain/repository/conversation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetConversationByUserIdAndSellerIdUseCase
    extends StateNotifier<AsyncValue<ConversationDataEntity?>> {
  GetConversationByUserIdAndSellerIdUseCase(this.repo)
      : super(const AsyncValue.data(null));
  final IConversationRepository repo;

  Future<void> execute({
    required String sellerID,
    required String userID,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getConversationByUserIdAndSellerId(
      sellerID: sellerID,
      userID: userID,
    );

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
