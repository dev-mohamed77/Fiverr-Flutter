// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/gigs/data/data_source/gig_images_remote_data_source.dart';
import 'package:fiverr/features/gigs/data/model/gig_model.dart';
import 'package:fiverr/features/gigs/domain/repository/gig_images_repository.dart';

class GigImagesRepositoryImp implements GigImagesRepository {
  final GigImagesRemoteDataSource remoteDataSource;
  GigImagesRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<GigImageModel>> addImageOfTheGig(
      String gigId, File image) async {
    try {
      final result = await remoteDataSource.addImageOfTheGig(gigId, image);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteImageOfTheGig(
      String imageId, String gigId) async {
    try {
      final result = await remoteDataSource.deleteGigImages(imageId, gigId);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
