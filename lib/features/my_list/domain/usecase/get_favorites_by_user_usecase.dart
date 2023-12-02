import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/my_list/domain/entity/my_list_entity.dart';
import 'package:fiverr/features/my_list/domain/repository/my_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetFavoritesByUserUseCase
    extends StateNotifier<AsyncValue<List<MyListEntity>?>> {
  GetFavoritesByUserUseCase(this.repo) : super(const AsyncValue.loading()) {
    execute();
  }

  final IMyListRepository repo;

  Future<void> execute() async {
    state = const AsyncValue.loading();

    final result = await repo.getFavoritesByUser();

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }

  void deleteFavorite(String favoriteId) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    items.removeWhere((element) => element.id == favoriteId);

    state = AsyncValue.data(items);
  }
}
