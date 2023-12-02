import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/reviews/domain/repository/reviews_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteReviewsUseCase extends StateNotifier<AsyncValue<String?>> {
  DeleteReviewsUseCase(this.repo) : super(const AsyncValue.data(null));

  final IReviewsRepository repo;

  Future<void> execute({
    required String id,
    required String description,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteReview(id);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
