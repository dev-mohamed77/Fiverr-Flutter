import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/skill/domain/repository/skill_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteSkillUseCase extends StateNotifier<AsyncValue<String?>> {
  DeleteSkillUseCase(this.repo) : super(const AsyncValue.data(null));

  final ISkillRepository repo;

  Future<void> execute({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteSkill(id);

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
