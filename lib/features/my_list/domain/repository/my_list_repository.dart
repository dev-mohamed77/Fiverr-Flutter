import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/my_list/domain/entity/my_list_entity.dart';

abstract class IMyListRepository {
  Future<ApiResult<MyListEntity>> addFavorite({required String gigId});
  Future<ApiResult<List<MyListEntity>>> getFavoritesByUser();
  Future<ApiResult<String>> deleteFavorite({required String gigId});
}
