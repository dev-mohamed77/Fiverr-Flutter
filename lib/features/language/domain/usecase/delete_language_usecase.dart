import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/language/domain/repository/language_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteLanguageUseCase extends StateNotifier<AsyncValue<String?>> {
  DeleteLanguageUseCase(this.repo) : super(const AsyncValue.data(null));

  final ILanguageRepository repo;

  Future<void> execute({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteLanguage(id);

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
