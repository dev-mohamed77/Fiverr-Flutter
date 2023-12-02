import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/skill/domain/entity/skill_entity.dart';
import 'package:fiverr/features/skill/domain/repository/skill_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateSkillUseCase extends StateNotifier<AsyncValue<SkillEntity?>> {
  CreateSkillUseCase(this.repo) : super(const AsyncValue.data(null));

  final ISkillRepository repo;

  Future<void> execute({
    required String sellerId,
    required String skill,
    required String level,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.createSkill(
      sellerId: sellerId,
      skill: skill,
      level: level,
    );

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
}
