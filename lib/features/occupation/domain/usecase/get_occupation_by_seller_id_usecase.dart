import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/occupation/domain/entity/occupation_entity.dart';
import 'package:fiverr/features/occupation/domain/repository/occupation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetOccupationsBySellerIdUseCase
    extends StateNotifier<AsyncValue<List<OccupationEntity>?>> {
  GetOccupationsBySellerIdUseCase(this.repo)
      : super(const AsyncValue.data(null));

  final IOccupationRepository repo;

  Future<void> execute({
    required String sellerId,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getOccupationBySellerId(sellerId);

    result.when(
      success: (data) {
        state = AsyncValue.data(data);
      },
      failure: (errorHandler) {
        state = AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandler),
          StackTrace.current,
        );
      },
    );
  }

  // add Occupation
  void addOccupation(OccupationEntity entity) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    items.add(entity);

    state = AsyncValue.data(items);
  }

  // add Occupation
  void updateOccupation(OccupationEntity entity) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    final index = items.indexWhere((element) => element.id == entity.id);
    if (index != -1) {
      items
        ..removeAt(index)
        ..insert(index, entity);
    }

    state = AsyncValue.data(items);
  }

  void deleteOccupation(OccupationEntity entity) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    items.remove(entity);

    state = AsyncValue.data(items);
  }
}
