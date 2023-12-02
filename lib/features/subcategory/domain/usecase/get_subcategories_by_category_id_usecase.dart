import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/explore/presentation/manager/select_category_provider.dart';
import 'package:fiverr/features/subcategory/domain/entity/sub_category_entity.dart';
import 'package:fiverr/features/subcategory/domain/repository/subcategory_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetSubCategoriesByCategoryIDUseCase
    extends StateNotifier<AsyncValue<List<SubCategoryEntity>?>> {
  GetSubCategoriesByCategoryIDUseCase(this.repo, this.ref)
      : super(const AsyncValue.data(null));

  final SubCategoryRepository repo;
  final Ref ref;

  final limit = 15;
  int page = 1;
  bool _noItemMore = false;

  bool get noItemMore => _noItemMore;

  Future<void> execute(
    String id,
  ) async {
    state = const AsyncValue.loading();

    final result = await repo.getSubCategoriesByCategoryID(id,
        page: page.toString(), limit: limit.toString());

    result.when(
      success: (data) {
        _noItemMore = data.length < limit;
        state = AsyncValue.data(data);
      },
      failure: (errorHandle) {
        state = AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandle),
          StackTrace.current,
        );
      },
    );
  }

  loadedMoreData() {
    if (!_noItemMore) {
      page++;

      _fetchSubCategories();
    }
  }

  void _fetchSubCategories() async {
    final category = ref.watch(selectCategoryProvider);

    final result = await repo.getSubCategoriesByCategoryID(
      category?.id ?? "",
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
