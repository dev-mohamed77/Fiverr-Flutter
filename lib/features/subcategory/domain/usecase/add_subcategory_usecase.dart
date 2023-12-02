import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/subcategory/domain/entity/sub_category_entity.dart';
import 'package:fiverr/features/subcategory/domain/repository/subcategory_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddSubCategoryUseCase
    extends StateNotifier<AsyncValue<SubCategoryEntity?>> {
  AddSubCategoryUseCase(this.repo) : super(const AsyncValue.data(null));

  final SubCategoryRepository repo;

  Future<void> execute({
    required String name,
    required String category,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.addSubCategory(name: name, category: category);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
