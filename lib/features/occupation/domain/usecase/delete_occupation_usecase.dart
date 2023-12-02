import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/occupation/domain/repository/occupation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteOccupationUseCase extends StateNotifier<AsyncValue<String?>> {
  DeleteOccupationUseCase(this.repo) : super(const AsyncValue.data(null));

  final IOccupationRepository repo;

  Future<void> execute({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteOccupation(id);

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
