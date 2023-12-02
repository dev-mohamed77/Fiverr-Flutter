import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/my_list/domain/entity/my_list_entity.dart';
import 'package:fiverr/features/my_list/domain/repository/my_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddFavoriteUseCase extends StateNotifier<AsyncValue<MyListEntity?>> {
  AddFavoriteUseCase(this.repo) : super(const AsyncValue.loading());

  final IMyListRepository repo;

  Future<void> execute({required String gigId}) async {
    state = const AsyncValue.loading();

    final result = await repo.addFavorite(gigId: gigId);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
