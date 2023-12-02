import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/explore/domain/repository/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateCategoryUseCase extends StateNotifier<AsyncValue<CategoryEntity?>> {
  UpdateCategoryUseCase(this.repo) : super(const AsyncValue.data(null));

  final CategoryRepository repo;

  Future<void> execute({required String id, required String name}) async {
    state = const AsyncValue.loading();

    final result = await repo.updateCategoryByID(id, name: name);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
