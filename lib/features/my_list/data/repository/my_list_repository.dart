// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/my_list/data/data_source/my_list_remote_data_source.dart';
import 'package:fiverr/features/my_list/domain/entity/my_list_entity.dart';
import 'package:fiverr/features/my_list/domain/repository/my_list_repository.dart';

class MyListRepositoryImp implements IMyListRepository {
  final MyListRemoteDataSource remoteDataSource;
  MyListRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<MyListEntity>> addFavorite({required String gigId}) async {
    try {
      final result = await remoteDataSource.addFavorite(gigId: gigId);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteFavorite({required String gigId}) async {
    try {
      final result = await remoteDataSource.deleteFavorite(gigId: gigId);

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<MyListEntity>>> getFavoritesByUser() async {
    try {
      final result = await remoteDataSource.getFavoritesByUser();

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
