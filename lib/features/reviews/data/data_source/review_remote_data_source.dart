// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:fiverr/features/reviews/data/model/review_model.dart';

abstract class ReviewRemoteDataSource {
  Future<ReviewDataModel> createReview({
    required String gigId,
    required int star,
    required String description,
  });
  Future<ReviewModel> getReviewsByGigId(
    String gigId, {
    String? limit,
    String? page,
    String? sort,
  });
  Future<ReviewDataModel> updateReview(String id,
      {required String description});
  Future<String> deleteReview(String id);
}

class ReviewRemoteDataSourceImp implements ReviewRemoteDataSource {
  final NetWorkService netWorkService;
  ReviewRemoteDataSourceImp({
    required this.netWorkService,
  });

  @override
  Future<ReviewDataModel> createReview({
    required String gigId,
    required int star,
    required String description,
  }) async {
    final response = await netWorkService.postData(
      "reviews",
      data: {
        "gig": gigId,
        "star": star,
        "description": description,
      },
    );

    final data = response.data["result"];

    return ReviewDataModel.fromMap(data);
  }

  @override
  Future<ReviewModel> getReviewsByGigId(
    String gigId, {
    String? limit,
    String? page,
    String? sort,
  }) async {
    final response = await netWorkService.getData(
      "$gigId/reviews-gig",
      queryParams: {
        "limit": limit,
        "page": page,
        "sort": sort,
      },
    );

    final data = response.data;

    return ReviewModel.fromMap(data);
  }

  @override
  Future<ReviewDataModel> updateReview(
    String id, {
    required String description,
  }) async {
    final response = await netWorkService.updateData(
      "reviews/$id",
      data: {
        "description": description,
      },
    );

    final data = response.data["result"];

    return ReviewDataModel.fromMap(data);
  }

  @override
  Future<String> deleteReview(String id) async {
    final response = await netWorkService.deleteData(
      "reviews/$id",
    );

    final data = response.data["result"];

    return data;
  }
}
