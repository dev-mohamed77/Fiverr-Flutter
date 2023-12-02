import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/features/reviews/domain/entity/review_entity.dart';
import 'package:fiverr/features/reviews/domain/repository/reviews_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateReviewsUseCase
    extends StateNotifier<AsyncValue<ReviewDataEntity?>> {
  UpdateReviewsUseCase(this.repo) : super(const AsyncValue.data(null));

  final IReviewsRepository repo;

  Future<void> execute({
    required String id,
    required String description,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.updateReview(
      id,
      description: description,
    );

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
