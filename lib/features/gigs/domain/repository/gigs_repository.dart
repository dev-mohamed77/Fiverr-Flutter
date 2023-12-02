import 'dart:io';

import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';

abstract class GigsRepository {
  Future<ApiResult<GigEntity>> createGig({
    required String title,
    required String description,
    required String price,
    required String categoryId,
    required String subCategoryId,
    required File coverImage,
    required List<File> images,
    required String deliveryTime,
  });

  Future<ApiResult<List<GigEntity>>> getGigsBySubCategoryId(
    String subCategoryID, {
    String? page,
    String? limit,
    String? deliveryTime,
    String? maxPrice,
    String? minPrice,
    String? language,
    String? country,
  });

  Future<ApiResult<List<GigEntity>>> getGigsByCategoryId(
    String categoryID, {
    String? page,
    String? limit,
  });

  Future<ApiResult<List<GigEntity>>> getGigsBySellerId(
    String sellerId, {
    String? page,
    String? limit,
  });

  Future<ApiResult<GigEntity>> updateGigById(
    String gigId, {
    String? title,
    String? description,
    String? price,
    String? categoryId,
    String? subCategoryId,
    File? coverImage,
    String? deliveryTime,
  });

  Future<ApiResult<String>> deleteGigById(String gigId);
}
