import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/domain/repository/gigs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetGigsBySellerIdUseCase
    extends StateNotifier<AsyncValue<List<GigEntity>?>> {
  GetGigsBySellerIdUseCase(this.repo) : super(const AsyncValue.data(null));
  final GigsRepository repo;

  final limit = 15;
  int page = 1;
  bool _noItemMore = false;

  bool get noItemMore => _noItemMore;

  Future<void> execute(
    String sellerID,
  ) async {
    state = const AsyncValue.loading();

    final result = await repo.getGigsBySellerId(
      sellerID,
      page: page.toString(),
      limit: limit.toString(),
    );

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

  loadedMoreData(
    String sellerID,
  ) {
    if (!_noItemMore) {
      page++;

      _fetchGigsBySubCategoryId(sellerID);
    }
  }

  void _fetchGigsBySubCategoryId(
    String sellerID,
  ) async {
    final result = await repo.getGigsBySellerId(
      sellerID,
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

  void addGig(GigEntity entity) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    items.add(entity);

    state = AsyncValue.data(items);
  }

  void updateGig(GigEntity entity) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    final index = items.indexWhere((gig) => gig.id == entity.id);

    if (index != -1) {
      items
        ..removeAt(index)
        ..insert(index, entity);
    }

    state = AsyncValue.data(items);
  }

  void deleteGig(String gigId) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    items.removeWhere((gig) => gig.id == gigId);

    state = AsyncValue.data(items);
  }
}
