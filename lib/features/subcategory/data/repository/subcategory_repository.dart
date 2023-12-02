// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fiverr/core/service/network_service/api/api_error_handle.dart';
import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/subcategory/data/data_source/subcategory_remote_data_source.dart';
import 'package:fiverr/features/subcategory/domain/entity/sub_category_entity.dart';
import 'package:fiverr/features/subcategory/domain/repository/subcategory_repository.dart';

class SubCategoryRepositoryImp implements SubCategoryRepository {
  final SubCategoryRemoteDataSource remoteDataSource;
  SubCategoryRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<SubCategoryEntity>> addSubCategory({
    required String name,
    required String category,
  }) async {
    try {
      final data =
          await remoteDataSource.addSubCategory(name: name, category: category);

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<SubCategoryEntity>>> getSubCategories(
      {String? page, String? limit}) async {
    try {
      final data =
          await remoteDataSource.getSubCategories(page: page, limit: limit);

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<SubCategoryEntity>>> getSubCategoriesByCategoryID(
      String id,
      {String? page,
      String? limit}) async {
    try {
      final data = await remoteDataSource.getSubCategoriesByCategoryID(
        id,
        page: page,
        limit: limit,
      );

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SubCategoryEntity>> getSubCategoryByID(String id) async {
    try {
      final data = await remoteDataSource.getSubCategoryByID(id);

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SubCategoryEntity>> updateSubCategoryByID(String id,
      {required String name}) async {
    try {
      final data = await remoteDataSource.updateSubCategoryByID(id, name: name);

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> deleteSubCategoryByID(String id) async {
    try {
      final data = await remoteDataSource.deleteSubCategoryByID(id);

      return ApiResult.success(data);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}
