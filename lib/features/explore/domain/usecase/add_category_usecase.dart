import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/explore/domain/repository/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCategoryUseCase extends StateNotifier<AsyncValue<CategoryEntity?>> {
  AddCategoryUseCase(this.repo) : super(const AsyncValue.data(null));

  final CategoryRepository repo;

  Future<void> execute({
    required String name,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.addCategory(name: name);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
