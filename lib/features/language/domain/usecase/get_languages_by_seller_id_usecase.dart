import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/language/domain/entity/language_entity.dart';
import 'package:fiverr/features/language/domain/repository/language_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetLanguagesBySellerIdUseCase
    extends StateNotifier<AsyncValue<List<LanguageEntity>?>> {
  GetLanguagesBySellerIdUseCase(this.repo) : super(const AsyncValue.data(null));

  final ILanguageRepository repo;

  Future<void> execute({
    required String sellerId,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.getLanguagesBySellerId(sellerId);

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

  // add Language
  void addLanguage(LanguageEntity entity) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    items.add(entity);

    state = AsyncValue.data(items);
  }

  // add Language
  void updateLanguage(LanguageEntity entity) {
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

  void deleteLanguage(LanguageEntity entity) {
    final items = state.value ?? [];

    state = const AsyncValue.loading();

    items.remove(entity);

    state = AsyncValue.data(items);
  }
}
