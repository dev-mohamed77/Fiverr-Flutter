// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/seller/data/data_source/seller_remote_data_source.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';
import 'package:fiverr/features/seller/domain/repository/seller_repository.dart';

class SellerRepositoryImp implements ISellerRepository {
  final SellerRemoteDataSource remoteDataSource;

  SellerRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<SellerEntity>> createSeller({
    required String fullName,
    required String displayName,
    required String description,
    required String image,
    String? website,
  }) async {
    try {
      final result = await remoteDataSource.createSeller(
        fullName: fullName,
        displayName: displayName,
        description: description,
        image: image,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SellerEntity>> getSellerByID(String id) async {
    try {
      final result = await remoteDataSource.getSellerByID(id);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SellerEntity>> getSellerByLoggedUser() async {
    try {
      final result = await remoteDataSource.getSellerByLoggedUser();

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SellerEntity>> updateSeller(
    String id, {
    String? fullName,
    String? displayName,
    String? description,
    String? image,
    String? website,
  }) async {
    try {
      final result = await remoteDataSource.updateSeller(
        id,
        updateSeller: UpdateSeller(
          fullName: fullName,
          displayName: displayName,
          description: description,
          image: image,
          website: website,
        ),
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteSeller(String id) async {
    try {
      final result = await remoteDataSource.deleteSeller(id);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
