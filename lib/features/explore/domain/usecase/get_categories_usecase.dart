import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/explore/domain/repository/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetCategoriesUseCase
    extends StateNotifier<AsyncValue<List<CategoryEntity>?>> {
  GetCategoriesUseCase(this.repo) : super(const AsyncValue.data(null)) {
    execute();
  }

  final CategoryRepository repo;

  final limit = 15;
  int page = 1;
  bool _noItemMore = false;

  bool get noItemMore => _noItemMore;

  Future<void> execute() async {
    state = const AsyncValue.loading();

    final result = await repo.getCategories(
      page: page.toString(),
      limit: limit.toString(),
    );

    result.when(success: (data) {
      _noItemMore = data.length < limit;
      state = AsyncValue.data(data);
    }, failure: (errorHandle) {
      state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }

  loadedMoreData() {
    if (!_noItemMore) {
      page++;

      _fetchCategories();
    }
  }

  void _fetchCategories() async {
    final result = await repo.getCategories(
      page: page.toString(),
      limit: limit.toString(),
    );

    result.when(success: (data) {
      _noItemMore = data.length < limit;
      state = AsyncValue.data([...state.value ?? [], ...data]);
    }, failure: (errorHandle) {
      state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }
}
