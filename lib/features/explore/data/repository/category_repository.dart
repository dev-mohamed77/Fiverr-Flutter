// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/explore/data/data_source/category_remote_datas_ource.dart';
import 'package:fiverr/features/explore/domain/entity/category_entity.dart';
import 'package:fiverr/features/explore/domain/repository/category_repository.dart';

class CategoryRepositoryImp implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImp({
    required this.remoteDataSource,
  });
  @override
  Future<ApiResult<CategoryEntity>> addCategory({
    required String name,
  }) async {
    try {
      final data = await remoteDataSource.addCategory(name: name);

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories({
    String? page,
    String? limit,
  }) async {
    try {
      final data = await remoteDataSource.getCategories(
        page: page,
        limit: limit,
      );

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<CategoryEntity>> getCategoryByID(String id) async {
    try {
      final data = await remoteDataSource.getCategoryByID(
        id: id,
      );

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<CategoryEntity>> updateCategoryByID(String id,
      {required String name}) async {
    try {
      final data = await remoteDataSource.updateCategoryByID(
        id,
        name: name,
      );

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteCategoryByID(String id) async {
    try {
      final data = await remoteDataSource.deleteCategoryByID(id);

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
