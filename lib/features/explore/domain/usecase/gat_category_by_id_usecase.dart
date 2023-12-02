import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/explore/domain/repository/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetCategoryByIDUseCase
    extends StateNotifier<AsyncValue<CategoryEntity?>> {
  GetCategoryByIDUseCase(this.repo) : super(const AsyncValue.data(null));

  final CategoryRepository repo;

  Future<void> execute({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getCategoryByID(id);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
