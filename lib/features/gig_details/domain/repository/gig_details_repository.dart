import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/gigs/domain/entity/gig_entity.dart';

abstract class IGigDetailsRepository {
  Future<ApiResult<GigEntity>> getGigByID({
    required String id,
  });
}
