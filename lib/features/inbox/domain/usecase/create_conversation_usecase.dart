import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_data_entity.dart';
import 'package:fiverr/features/inbox/domain/repository/conversation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateConversationUseCase
    extends StateNotifier<AsyncValue<ConversationDataEntity?>> {
  CreateConversationUseCase(this.repo) : super(const AsyncValue.data(null));
  final IConversationRepository repo;

  Future<void> execute({
    required String sellerID,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.createConversation(sellerID: sellerID);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
