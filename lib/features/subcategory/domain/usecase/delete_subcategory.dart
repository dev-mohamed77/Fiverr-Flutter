import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/subcategory/domain/repository/subcategory_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteSubCategoryUseCase extends StateNotifier<AsyncValue<String?>> {
  DeleteSubCategoryUseCase(this.repo) : super(const AsyncValue.data(null));

  final SubCategoryRepository repo;

  Future<void> execute({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteSubCategoryByID(id);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
