import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/chat/domain/repository/messages_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteMessagesUseCase extends StateNotifier<AsyncValue<String?>> {
  DeleteMessagesUseCase(this.repo) : super(const AsyncValue.data(null));

  final MessagesRepository repo;

  Future<void> execute(
    String id, {
    required String sender,
    required String conversationId,
    required String sellerId,
    required String userId,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteCategoryByID(
      id,
      sender: sender,
      conversationId: conversationId,
      sellerId: sellerId,
      userId: userId,
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
