import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/reviews/domain/entity/review_entity.dart';

abstract class IReviewsRepository {
  Future<ApiResult<ReviewDataEntity>> createReview({
    required String gigId,
    required int star,
    required String description,
  });
  Future<ApiResult<ReviewEntity>> getReviewsByGigId(
    String gigId, {
    String? limit,
    String? page,
    String? sort,
  });
  Future<ApiResult<ReviewDataEntity>> updateReview(String id,
      {required String description});
  Future<ApiResult<String>> deleteReview(String id);
}
