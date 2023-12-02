// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/occupation/data/data_source/occupation_remote_data_source.dart';
import 'package:fiverr/features/occupation/domain/entity/occupation_entity.dart';
import 'package:fiverr/features/occupation/domain/repository/occupation_repository.dart';

class OccupationRepositoryImp implements IOccupationRepository {
  final OccupationRemoteDataSource remoteDataSource;
  OccupationRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<OccupationEntity>> createOccupation({
    required String sellerId,
    required String specialization,
    required String occupation,
    required String from,
    required String to,
  }) async {
    try {
      final result = await remoteDataSource.createOccupation(
        sellerId: sellerId,
        specialization: specialization,
        occupation: occupation,
        from: from,
        to: to,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<OccupationEntity>>> getOccupationBySellerId(
      String sellerId) async {
    try {
      final result = await remoteDataSource.getOccupationBySellerId(sellerId);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<OccupationEntity>> updateOccupation(
    String id, {
    String? specialization,
    String? occupation,
    String? from,
    String? to,
  }) async {
    try {
      final result = await remoteDataSource.updateOccupation(
        id,
        specialization: specialization,
        occupation: occupation,
        from: from,
        to: to,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteOccupation(String id) async {
    try {
      final result = await remoteDataSource.deleteOccupation(id);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
