import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/occupation/domain/entity/occupation_entity.dart';

abstract class IOccupationRepository {
  Future<ApiResult<OccupationEntity>> createOccupation({
    required String sellerId,
    required String specialization,
    required String occupation,
    required String from,
    required String to,
  });
  Future<ApiResult<List<OccupationEntity>>> getOccupationBySellerId(
    String sellerId,
  );
  Future<ApiResult<OccupationEntity>> updateOccupation(
    String id, {
    String? specialization,
    String? occupation,
    String? from,
    String? to,
  });
  Future<ApiResult<String>> deleteOccupation(String id);
}
