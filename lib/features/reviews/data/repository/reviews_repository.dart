// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/reviews/data/data_source/review_remote_data_source.dart';
import 'package:fiverr/features/reviews/domain/entity/review_entity.dart';
import 'package:fiverr/features/reviews/domain/repository/reviews_repository.dart';

class ReviewsRepositoryImp implements IReviewsRepository {
  final ReviewRemoteDataSource dataSource;
  ReviewsRepositoryImp({
    required this.dataSource,
  });

  @override
  Future<ApiResult<ReviewDataEntity>> createReview({
    required String gigId,
    required int star,
    required String description,
  }) async {
    try {
      final data = await dataSource.createReview(
        gigId: gigId,
        star: star,
        description: description,
      );

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteReview(String id) async {
    try {
      final data = await dataSource.deleteReview(id);

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<ReviewEntity>> getReviewsByGigId(String gigId,
      {String? limit, String? page, String? sort}) async {
    try {
      final data = await dataSource.getReviewsByGigId(
        gigId,
        limit: limit,
        page: page,
        sort: sort,
      );

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<ReviewDataEntity>> updateReview(String id,
      {required String description}) async {
    try {
      final data = await dataSource.updateReview(
        id,
        description: description,
      );

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
