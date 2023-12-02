import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/language/domain/entity/language_entity.dart';
import 'package:fiverr/features/language/domain/repository/language_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateLanguageUseCase extends StateNotifier<AsyncValue<LanguageEntity?>> {
  CreateLanguageUseCase(this.repo) : super(const AsyncValue.data(null));

  final ILanguageRepository repo;

  Future<void> execute({
    required String language,
    required String level,
    required String sellerId,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.createLanguage(
      language: language,
      level: level,
      sellerId: sellerId,
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
