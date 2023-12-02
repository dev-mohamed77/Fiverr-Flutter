import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/seller/domain/entity/seller_entity.dart';

abstract class ISellerRepository {
  Future<ApiResult<SellerEntity>> createSeller({
    required String fullName,
    required String displayName,
    required String description,
    required String image,
    String? website,
  });
  Future<ApiResult<SellerEntity>> getSellerByID(String id);

  Future<ApiResult<SellerEntity>> getSellerByLoggedUser();

  Future<ApiResult<SellerEntity>> updateSeller(
    String id, {
    String? fullName,
    String? displayName,
    String? description,
    String? image,
    String? website,
  });
  Future<ApiResult<String>> deleteSeller(String id);
}
