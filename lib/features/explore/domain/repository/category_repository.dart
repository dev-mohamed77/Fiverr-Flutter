import 'package:fiverr/core/service/network_service/api/api_result.dart';
import 'package:fiverr/features/explore/domain/entity/category_entity.dart';

abstract class CategoryRepository {
  Future<ApiResult<CategoryEntity>> addCategory({
    required String name,
  });
  Future<ApiResult<List<CategoryEntity>>> getCategories({
    String? page,
    String? limit,
  });
  Future<ApiResult<CategoryEntity>> getCategoryByID(String id);
  Future<ApiResult<CategoryEntity>> updateCategoryByID(String id,
      {required String name});
  Future<ApiResult<String>> deleteCategoryByID(String id);
}
