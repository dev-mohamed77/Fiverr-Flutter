import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/language/domain/entity/language_entity.dart';
import 'package:fiverr/features/language/domain/repository/language_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateLanguageUseCase extends StateNotifier<AsyncValue<LanguageEntity?>> {
  UpdateLanguageUseCase(this.repo) : super(const AsyncValue.data(null));

  final ILanguageRepository repo;

  Future<void> execute(
    String id, {
    required String language,
    required String level,
  }) async {
    state = const AsyncValue.loading();

    final result =
        await repo.updateLanguage(id, language: language, level: level);

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
