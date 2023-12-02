import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/subcategory/domain/entity/sub_category_entity.dart';
import 'package:fiverr/features/subcategory/domain/repository/subcategory_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetSubCategoriesUseCase
    extends StateNotifier<AsyncValue<List<SubCategoryEntity>?>> {
  GetSubCategoriesUseCase(this.repo) : super(const AsyncValue.data(null)) {
    execute();
  }

  final SubCategoryRepository repo;

  Future<void> execute({
    String? page,
    String? limit,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getSubCategories(page: page, limit: limit);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
