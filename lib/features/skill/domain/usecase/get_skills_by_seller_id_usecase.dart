import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/skill/domain/entity/skill_entity.dart';
import 'package:fiverr/features/skill/domain/repository/skill_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetSkillsBySellerIdUseCase
    extends StateNotifier<AsyncValue<List<SkillEntity>?>> {
  GetSkillsBySellerIdUseCase(this.repo) : super(const AsyncValue.data(null));

  final ISkillRepository repo;

  Future<void> execute({
    required String sellerId,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getSkillsBySellerId(sellerId);

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

  // add Skill
  void addSkill(SkillEntity entity) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    items.add(entity);

    state = AsyncValue.data(items);
  }

  // add Skill
  void updateSkill(SkillEntity entity) {
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

  void deleteSkill(SkillEntity entity) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    items.remove(entity);

    state = AsyncValue.data(items);
  }
}
