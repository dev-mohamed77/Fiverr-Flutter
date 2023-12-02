import 'dart:io';

import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/gigs/data/data_source/gigs_remote_data_source.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';
import 'package:fiverr/features/gigs/domain/repository/gigs_repository.dart';

class GigsRepositoryImp implements GigsRepository {
  final GigsRemoteDataSource remoteDataSource;

  GigsRepositoryImp({required this.remoteDataSource});

  @override
  Future<ApiResult<GigEntity>> createGig({
    required String title,
    required String description,
    required String price,
    required String categoryId,
    required String subCategoryId,
    required File coverImage,
    required List<File> images,
    required String deliveryTime,
  }) async {
    try {
      final result = await remoteDataSource.createGig(
          title: title,
          description: description,
          price: price,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
          coverImage: coverImage,
          images: images,
          deliveryTime: deliveryTime);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<GigEntity>>> getGigsBySubCategoryId(
    String subCategoryID, {
    String? page,
    String? limit,
    String? deliveryTime,
    String? maxPrice,
    String? minPrice,
    String? language,
    String? country,
  }) async {
    try {
      final result = await remoteDataSource.getGigsBySubCategoryId(
        subCategoryID,
        page: page,
        limit: limit,
        deliveryTime: deliveryTime,
        maxPrice: maxPrice,
        minPrice: minPrice,
        language: language,
        country: country,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<GigEntity>>> getGigsByCategoryId(
    String categoryID, {
    String? page,
    String? limit,
  }) async {
    try {
      final result = await remoteDataSource.getGigsByCategoryId(
        categoryID,
        page: page,
        limit: limit,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<GigEntity>>> getGigsBySellerId(
    String sellerId, {
    String? page,
    String? limit,
  }) async {
    try {
      final result = await remoteDataSource.getGigsBySellerId(
        sellerId,
        page: page,
        limit: limit,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<GigEntity>> updateGigById(
    String gigId, {
    String? title,
    String? description,
    String? price,
    String? categoryId,
    String? subCategoryId,
    File? coverImage,
    String? deliveryTime,
  }) async {
    try {
      final result = await remoteDataSource.updateGigById(
        gigId,
        updateGig: UpdateGigData(
          categoryId: categoryId,
          title: title,
          coverImage: coverImage?.path,
          deliveryTime: deliveryTime,
          description: description,
          price: price,
          subCategoryId: subCategoryId,
        ),
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteGigById(String gigId) async {
    try {
      final result = await remoteDataSource.deleteGigById(gigId);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
