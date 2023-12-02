import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/inbox/domain/entity/conversation_data_entity.dart';
import 'package:fiverr/features/inbox/domain/repository/conversation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetConversationsByUserIdUseCase
    extends StateNotifier<AsyncValue<List<ConversationDataEntity>>> {
  GetConversationsByUserIdUseCase(this.repo)
      : super(const AsyncValue.loading()) {
    execute();
  }
  final IConversationRepository repo;

  final limit = 15;
  int page = 1;
  bool _noItemMore = false;
  bool get noItemMore => _noItemMore;

  Future<void> execute() async {
    state = const AsyncValue.loading();

    final result = await repo.getConversationsByUserId(
      page: page.toString(),
      limit: limit.toString(),
    );

    result.when(
      success: (data) {
        state = AsyncValue.data(data.result);
      },
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }

  loadedMoreData() {
    if (!_noItemMore) {
      page++;

      _fetchConversationsByUserId();
    }
  }

  void _fetchConversationsByUserId() async {
    final result = await repo.getConversationsByUserId(
      page: page.toString(),
      limit: limit.toString(),
    );

    result.when(success: (data) {
      _noItemMore = data.length < limit;
      state = AsyncValue.data([...state.value ?? [], ...data.result]);
    }, failure: (errorHandle) {
      state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }
}
